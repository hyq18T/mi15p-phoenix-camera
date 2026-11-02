# 小米 15 Pro：OS4.0.0.16 `vendor_dlkm` 原版与作者修改版对比

## 一、结论先说

这版作者修改不是“只替换 5 个充电 KO”，也不是在原版 KO 里零散改几个参数，而是把整套与充电、电量计、容量策略、温控、PD/PPS、无线充和充电分区有关的旧版代码回移到 OS4 镜像中。

对比 391 个两边共有的 KO 后，结果如下：

| 类型 | 数量 | 含义 |
|---|---:|---|
| `.text` 与原版相同 | 365 | 只有 KO 重新打包后的元数据变化，实际机器码没变 |
| `.text` 与 OS3.0.305 旧版完全相同 | 26 | 真正的旧版充电代码回移 |
| 作者自行修改出的新机器码 | 0 | 没有发现作者自己改出来的自定义 `.text` |
| 作者额外加入 | 1 个文件名 | 多出一个 `sc8581.ko`，但其内容与作者版 `sc8581_sy6541.ko` 完全相同 |

因此，作者版实现旧版快充手感的根本方式，是把旧版充电相关 KO 的功能代码搬回 OS4.0.0.16 的模块包中，再按 OS4 内核版本重新生成 KO 外层元数据。

需要注意：所谓“旧版代码”只是相对新系统少了一部分新加的软件限制、容量策略和监控逻辑，不等于硬件 OVP、JEITA、PMIC/CP 自身保护全部消失。

## 二、两个镜像的身份

| 项目 | 原版 | 作者版 |
|---|---|---|
| 用户提供路径 | 桌面 OTA 目录 | `Downloads\vendor_dlkm.img` |
| 文件大小 | 88,707,072 字节 | 86,102,016 字节 |
| SHA-256 | `68BCF982AD6EBAE414038E01433F4BB03847D72DFBA983C52A03E11039A735B5` | `E7F6A11AB1B948520672472D55444508D40216A77D64432A99F6FAF4CE98AEF1` |
| 镜像内部版本 | `OS4.0.0.16.XOBCN` | `OS4.0.0.16.XOBCN` |
| 文件系统 | EROFS | EROFS |
| EROFS UUID | `51bfdb91-50cc-50c7-97e3-b7f6dd11689a` | `44b3a86a-d011-9470-b39b-da72ed9f1794` |
| 文件数量 | 409 | 410 |
| AVB / dm-verity footer | 有完整 Hashtree + FEC | 没有 AVB footer |

### 关于目录名 `.17`

桌面目录名虽然是：

`haotian-ota_full-OS4.0.0.17.XOBCNXM-user-17.0-052b694294`

但镜像里的 `ro.vendor_dlkm.build.version.incremental` 和 AVB fingerprint 都明确写着：

`OS4.0.0.16.XOBCN`

因此判断镜像内容时应以 `vendor_dlkm` 内部版本为准，不能只看外层下载目录名称。

### 关于 AVB

原版带有：

- 分区名：`vendor_dlkm`
- dm-verity 数据块：4096 字节
- SHA-256 Hashtree
- 2 个 FEC roots
- Salt：`bf06f1312bddbad350accf3f06458aa54554dd2f9fdb7df9400cc70e74f059d6`
- AVB 算法：`NONE`

作者版直接读不到 AVB footer，`avbtool` 会报“不是 vbmeta 镜像”。这说明作者版是一个重新打包过的裸 EROFS 分区镜像；它能刷入不代表在任何系统版本、任何校验状态下都能安全启动。

## 三、核心 5 个充电 KO

| 模块 | 原版 `.text` | 作者版 `.text` | 与 OS3.0.305 的关系 |
|---|---:|---:|---|
| `mca_strategy_quickchg.ko` | 53,172 | 44,512 | 完全相同 |
| `bq27z561.ko` | 110,052 | 71,100 | 完全相同 |
| `mca_strategy_fg_comp.ko` | 52,980 | 35,512 | 完全相同 |
| `mca_strategy_buckchg.ko` | 29,892 | 25,612 | 完全相同 |
| `mca_buckchg_jeita.ko` | 12,196 | 9,468 | 完全相同 |

这 5 个模块已经决定了大半的充电行为差异：

- 快充策略模块回退到旧版，恢复旧的功率爬升和快充调节逻辑。
- 电量计模块移除了新版云端 FG、SOH 补偿、动态浮压、默认 FCC/Qmax/DCR 等扩展。
- 容量策略模块移除了新版 `smooth_new` SOC 平滑、关机/锂析出检测、容量异常 DFX 等逻辑。
- Buck 充电策略移除了新版 PPS 100W、旧模块循环降浮压、OTG 低温监控、紧急电量投票等部分逻辑。
- JEITA 模块移除了动态 ITERM、弱充终止电压、DT override、动态浮压等新版逻辑。

## 四、26 个回移到旧版代码的 KO

| KO | 主要被回退的功能 |
|---|---|
| `bq27z561.ko` | 云端 FG 更新、SOH 补偿、动态浮压、默认 FCC、Qmax、DCR、快充次数等新逻辑 |
| `charger_partition.ko` | 安全充电电流/电压限制、紧急电池序列号读写 |
| `mca_basic_wireless.ko` | CP VBUS error IRQ、无线 SOC 限制和新版无线状态处理 |
| `mca_bmd.ko` | 恢复旧版充电状态/DFX 枚举关系，无独立新增函数 |
| `mca_buckchg_jeita.ko` | 动态 ITERM、弱充 vterm、`buckchg_jeita_override`、动态浮压 |
| `mca_business_charger_comp.ko` | PPS 100W、最大功率报告、充电类型与无线状态的新版处理 |
| `mca_charge_mievent.ko` | 电池过压、容量异常、SOC 跳变、回充 SOC 异常事件 |
| `mca_charger_thermal.ko` | `charger_thermal_override` 和子节点温控覆盖解析 |
| `mca_connector_antiburn.ko` | 新版接口防烧监控逻辑，恢复旧版监测行为 |
| `mca_event.ko` | `mca_event_report_multiple_uevent` 多事件上报接口 |
| `mca_hwid.ko` | `mca_is_warsaw_p2_before` 及新版硬件识别 |
| `mca_pd_auth.ko` | 新版认证状态读取和 sysfs 处理 |
| `mca_platform_buckchg_class.ko` | `platform_class_buckchg_ops_set_cp_vendor_id` |
| `mca_platform_cp_class.ko` | 新版 CP VBUS errorhi/errorlo IRQ，恢复旧版 PMID2OUT UVP 接口 |
| `mca_platform_fg_ic_ops.ko` | Qmax、SN、库仑积分、CSD、快充次数、默认 FCC、动态浮压等 FG 接口 |
| `mca_protocol_pd_class.ko` | PPS 100W、低功耗修复、电池认证/容量/CP/无线等新版事件 |
| `mca_qcom_smem.ko` | 新电池序列号判断接口 |
| `mca_qcom_subpmic_proxy.ko` | CP vendor ID、新版通知和部分 sub-PMIC 行为 |
| `mca_quick_wireless.ko` | 新版无线快充启停、CP 错误和 PPS 100W 状态 |
| `mca_smart_charge.ko` | 紧急电池 SOC 限制、电池安全限制 DFX、新版智能充电算法 |
| `mca_strategy_buckchg.ko` | PPS 100W、`drop_fv_cycle`、OTG 低温监控、紧急电量处理 |
| `mca_strategy_class.ko` | PPS 100W 对外接口和多种新版策略状态 |
| `mca_strategy_fg_class.ko` | 补偿 FCC/RM、新版 SOC 平滑许可、动态浮压接口 |
| `mca_strategy_fg_comp.ko` | `smooth_new`、关机/ISC/锂析出检测、容量异常 DFX、动态浮压 |
| `mca_strategy_quickchg.ko` | 循环降 FCC、循环降浮压、CP OVP 强制退出、CP 启停条件、Vstep 扩展、PPS 100W、高温防过压 |
| `mca_wireless_revchg.ko` | 紧急电量时禁用反向无线充投票、新版反向充电事件和用户启停工作 |

## 五、最关键的快充策略变化

`mca_strategy_quickchg.ko` 是充电速度差异最大的模块。原版中存在的以下关键逻辑在作者版里被回退掉：

- `MCA_QUICK_CHG_DROP_FCC_STEP`
- `MCA_QUICK_CHG_CYCLE_COUNT`
- `drop_fcc_para`
- `drop_fv_cycle`
- `cycle_count`
- `mca_quick_charge_ovp_monitor_work`
- `mca_quick_charge_parse_enable_cp_para`
- `mca_quick_charge_parse_vstep_para`
- `mca_quick_charge_parse_vstep_ex_para`
- `mca_quick_charge_parse_third_pps_power_info`
- `support_pps_100w`
- `anti-overvoltage-strategy`
- `avoid-overvolt-at-high-temp`
- `platform_class_buckchg_ops_set_cp_vendor_id`

这解释了为什么作者版会恢复更接近旧版的功率爬升：旧版快充状态机没有新版的循环降流/降浮压、CP 过压监控强制退出、复杂 CP 启停条件和新版 Vstep 扩展。

## 六、电量计和容量层变化

`bq27z561.ko` 的原版明显比作者版复杂，原版包含这些作者版没有的逻辑：

- `fg_fw_clound_update`
- `fg_clound_update_workfunc`
- `check_fg_cloud_string`
- `SOH_COMPESATOPN`
- `soh_compesation`
- `fg_set_one_dynamic_fv`
- `FG_MAC_CMD_DYNAMIC_FV_FFC`
- `FG_MAC_CMD_DYNAMIC_FV_NORMAL`
- 默认 FCC、Qmax、SOH、DCR、快充次数等扩展

这说明作者版不包含新版的云端 FG 更新通道，也没有新版的动态浮压和 SOH 补偿那一整套逻辑。

`mca_strategy_fg_comp.ko` 则移除了新版 SOC 和容量管理层：

- `smooth_new` 整套 UI SOC 平滑
- `support_new_soc_smooth`
- `strategy_fg_set_allow_new_soc_smooth`
- `drop_fv_cycle`
- 紧急电池和关机电压更新
- ISC/锂析出检测
- 电池容量、SOC 跳变、回充 SOC 异常 DFX
- 动态浮压

所以作者版不只是“快充电流变大”，还同时回退了一部分新系统的电量显示、容量维护和充电次数相关逻辑。

## 七、`sc8581` 的特殊情况

原版只有：

`sc8581_sy6541.ko`

作者版有：

- `sc8581_sy6541.ko`：被替换为旧版 SC8581 代码，但填充了 OS4.0.0.16 的 vermagic
- `sc8581.ko`：与作者版 `sc8581_sy6541.ko` 两个文件的 SHA-256 完全相同

核对结果：

- 作者版两份 `sc8581` KO 的 `.text` 都与 OS3 旧版 `sc8581.ko` 相同。
- 作者版旧式 SC8581 文件与原版 OS3 文件相比，功能段相同，只有两处 `scmversion` 元数据不同。
- 作者镜像的 `modules.alias`、`modules.dep`、`modules.load`、`modules.blocklist`、`modules.softdep` 与原版完全一致。
- 系统实际按 `modules.alias` / `modules.load` 加载的是 `sc8581_sy6541.ko`。
- 额外增加的 `sc8581.ko` 没有被依赖表引用，属于多余的重复文件，正常情况下不会自动成为第二套驱动。

## 八、为什么它看起来更像旧版快充

作者版恢复旧版手感是多个模块共同作用的结果，不是单一参数：

1. 快充策略回到旧状态机，减少新版循环降流、降浮压和 CP 启停门槛。
2. 电量计去掉云端 FG、SOH 补偿、默认 FCC 和动态浮压扩展。
3. SOC/容量策略去掉 `smooth_new`、紧急电量、ISC/锂析出和容量异常检测。
4. JEITA/Buck 策略去掉动态 ITERM、弱充 vterm 和动态浮压。
5. PD/PPS、无线充和智能充电恢复到旧版接口组合。
6. SC8581 CP 驱动也换回旧版代码。

## 九、风险判断

### 1. 这是整套方案，不是单个 KO 替换

26 个 KO 之间存在导出符号和接口配套关系。只挑 5 个换，容易出现函数 undefined、CRC 不匹配、状态机不完整或充电异常。

### 2. 作者版是 `.16`，不能直接当成 `.19` 的成品

作者 KO 外层的 vermagic 是 OS4.0.0.16 的：

`6.6.57-android15-8-gbc807ab2c5a8-4k`

当前手机 OS4.0.0.19 的部分关键导出符号 CRC 已经变化，不能假设 `.16` 作者版 KO 可以原样搬入 `.19`。此前把重构分区刷入 `.19` 曾出现卡第一屏，随后已刷回官方 `.19`。

### 3. AVB footer 被移除

作者版没有原版的 Hashtree/FEC footer。即使某一版系统能刷入并运行，也不代表以后 OTA、恢复模式、fastbootd 或系统完整性校验都能接受它。

### 4. “旧版代码”仍有保护

回退掉的主要是新版软件层策略和监控，不代表 SC8581、PMIC、JEITA、温度、硬件过压等保护全部不存在。不能把作者版理解成真正“无限制”或可以长期无人值守地连续极限快充。

## 十、最终判断

作者版的实现思路是明确的：**以 OS4.0.0.16 的模块外壳和依赖关系为基础，把 26 个充电相关 KO 的功能代码替换成 OS3.0.305 的旧版代码，并额外复制一份 SC8581 旧驱动。**

它的优点是改动方向集中，确实针对新版快充、FG 容量策略和温控限制；缺点是：

- 去掉 AVB footer；
- 文件数量与原版不同；
- 26 个模块必须成套匹配；
- 只适用于对应的 `.16` 模块 ABI；
- 附带的 `sc8581.ko` 是多余副本；
- 不能直接作为当前 `.19` 的刷机成品。

本次只完成镜像拆包、代码、依赖和文件结构对比，没有修改、打包或刷入手机。
