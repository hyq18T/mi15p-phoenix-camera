# vendor_dlkm 镜像分析报告

日期：2026-11-02

## 一、文件状态

| 文件 | 系统版本 | 大小 | SHA-256 |
|---|---|---|---|
| `C:\Users\hyq-18T\Downloads\vendor_dlkm.img`（别人改的 4.0） | OS4.0.0.16.XOBCN | 86,102,016 | E7F6A11AB1B948520672472D55444508D40216A77D64432A99F6FAF4CE98AEF1 |
| `C:\Users\hyq-18T\Desktop\vendor_dlkm.img`（旧版） | OS3.0.305.0.WOBCNXM | 78,086,144 | F353BCE318BC1A8CA6F52F3A82709ABB980C709B9975FC4870ABF603B289F179 |
| `official_19_vendor_dlkm.img`（手机当前原版重新导出） | OS4.0.0.19.XOBCN | 88,707,072 | E64981C83DA1EF39ADD275C11F460561C2D5E792B75EB7AC12A4C02251851500 |

旧版没有被清掉；手机 `PayloadDumper` 目录里也有一份同样的 OS3.0.305 镜像。之前删掉的是 OS4.0.0.19 原版的导出副本，现已从手机分区重新完整导出。

## 二、镜像格式

两份都是 EROFS 只读文件系统，不是 sparse 镜像，已用 `fsck.erofs` 完整解包。

- 旧版解包目录：`old_official\`
- 别人 4.0 版解包目录：`modified_os4\`
- 手机官方 19 的充电相关模块：`official_19\lib\modules\`

## 三、关键发现：5 个充电 KO 是旧版代码

对 5 个核心充电模块做了 `.text` 代码段逐字节比对：

| 模块 | 旧版 OS3.0.305 | 别人 4.0.0.16 | 手机官方 OS4.0.0.19 |
|---|---:|---:|---:|
| `mca_strategy_quickchg.ko` | 44,512 | 44,512（完全相同） | 53,172 |
| `bq27z561.ko` | 71,100 | 71,100（完全相同） | 110,052 |
| `mca_strategy_fg_comp.ko` | 35,512 | 35,512（完全相同） | 52,980 |
| `mca_strategy_buckchg.ko` | 25,612 | 25,612（完全相同） | 29,892 |
| `mca_buckchg_jeita.ko` | 9,468 | 9,468（完全相同） | 12,196 |

结论：别人这份 4.0 镜像里的 5 个充电 KO，代码段与旧版 OS3.0.305 **逐字节完全一致**，只是重新链接成了 OS4 内核要求的 vermagic：

- 旧版 vermagic：`6.6.57-android15-8-g6f1d969db78f-4k`
- 4.0.0.16 / 4.0.0.19 vermagic：`6.6.57-android15-8-gbc807ab2c5a8-4k`

也就是说，这不是单纯把旧 KO 文件拖进去，而是把旧版充电代码按新内核重新打包过，所以能在 4.0 上加载。

## 四、别人这版去掉了什么

对比手机官方 4.0.0.19，别人 4.0.0.16 的 5 个 KO 缺少以下 19 新增逻辑：

- `mca_strategy_quickchg`：`MCA_QUICK_CHG_DROP_FCC_STEP`、`cur_cycle`、按循环降流、过压强制退出快充、`CHARGE_DFX_BATTERY_OVERVOLTAGE`
- `bq27z561`：`FG_IC_PROP_CLOUND_FG_FW_UPDATE`、`Parsed_Clound_Result`、云端 FG 固件/容量改写通道
- `mca_strategy_fg_comp`：`smooth_new` 系列新 SOC 平滑策略
- `mca_strategy_buckchg`：`STRATEGY_STATUS_TYPE_DROP_FLOAT_VOLT`、循环计数降浮压
- `mca_buckchg_jeita`：19 新增的高温分区、动态 ITERM、VFLOAT 等 JEITA 状态

另外，4.0.0.16 镜像相对旧版还新增了 `sc8581_sy6541.ko`、`mca_pwm_fan.ko` 等 4.0 平台模块，并移除了 `migt.ko`、`miwill.ko` 等旧模块；这些属于系统版本差异，不是充电改动。

## 五、能否直接刷到你的手机

你的手机是 **OS4.0.0.19**，这份镜像是 **OS4.0.0.16**，不能当作同版本原版直接刷：

- 整包刷入会把相机、显示、USB 等其他 16 版模块一起带回旧版本，存在开机异常和 USB 失效风险。
- 两者的内核 vermagic 相同，说明内核版本一致；理论上可以只提取这 5 个“旧策略、新 vermagic”的 KO，替换到 19 的 vendor_dlkm 里，但必须先核对模块符号 CRC 和依赖关系，不能直接盲刷。
- 更稳妥的做法是先做可拆包检查的 19 基底镜像，只替换这 5 个 KO，再在 fastbootd 验证。

## 六、建议下一步

1. 保留这份 4.0.0.16 镜像作为参考，不要整包刷入。
2. 以 `official_19_vendor_dlkm.img` 为基底，只替换上述 5 个 KO，制作 19 兼容测试镜像。
3. 刷入前先做 EROFS 回读校验、模块依赖检查和 AVB/verity 处理说明。
## 七、这 5 个 KO 能否单独放进 OS4.0.0.19

不能直接放。虽然 vermagic 相同，但模块之间的符号 CRC 已经变了：

- `mca_strategy_quickchg` / `mca_strategy_buckchg` / `mca_buckchg_jeita`：
  `mca_smartchg_if_ops_register` 在 16 是 `0xf068973d`，在 19 是 `0x85e2f9d0`
- `bq27z561`：
  `platform_fg_ic_ops_register` 在 16 是 `0x6a652a09`，在 19 是 `0x870b9e22`
- `mca_strategy_fg_comp`：
  `strategy_class_fg_ops_register` 在 16 是 `0x378db201`，在 19 是 `0x944e1834`
  `platform_fg_ops_qbg_send_chg_data` 在 16 是 `0x7db31002`，在 19 是 `0x1f521b43`

因此把 16 的这 5 个 KO 单独塞进 19 的 vendor_dlkm，加载时会报符号版本不一致，充电链会失效，不能这么做。

整包刷 16 的 vendor_dlkm 在理论上因为内核 vermagic 相同可能能开机，但那是把相机、显示、USB 等模块一起回退到 16，风险高于只改充电，不建议直接刷。