# 小米 15 Pro OS4.0.0.19 旧版快充移植

本目录包含小米 15 Pro（`haotian`）在 `OS4.0.0.19.XOBCNXM` 上恢复旧版快充策略的逆向分析工具、28 个已适配模块、成品 `vendor_dlkm` 镜像、官方回刷镜像和完整验证记录。

## 重要前提

**本仓库不提供 DTBO。**

必须自行准备并使用 `OS3.0.305` 或更早、且与设备和分区完全匹配的 `dtbo.img`。成品 `vendor_dlkm` 负责恢复旧版充电 KO；旧版快充爬升还需要对应的旧版 DTBO。不要把其他机型、其他版本或来源不明的 DTBO 混刷到本机。

本成品仅适用于：

- 设备：小米 15 Pro，代号 `haotian`，型号 `2410DPN6CC`
- 系统：`OS4.0.0.19.XOBCNXM`
- 槽位：当前 `_a` 槽
- 分区：`vendor_dlkm_a`
- 分区大小：`88,707,072` 字节

系统版本、槽位或分区不匹配时不要刷入。刷机前必须保留可进入 `fastbootd` 的手段，并先确认官方回刷镜像可用。

## 直接下载

- [旧版快充成品镜像](artifacts/vendor_dlkm_米15p_4.0.19.img)
- [OS4.0.0.19 官方回刷镜像](artifacts/vendor_dlkm_OS4.0.0.19_官方回刷.img)
- [全部文件 SHA-256 清单](SHA256SUMS)
- [使用说明](使用说明.md)
- [修改原理总结](修改原理总结.md)
- [下一次修改完整操作手册](下一次修改完整操作手册.md)

SHA-256：

```text
E237DD6E4094102A9CE49F0F7476380F5344C92DC6A5B1940AFE30FEC4544ED4  vendor_dlkm_米15p_4.0.19.img
E64981C83DA1EF39ADD275C11F460561C2D5E792B75EB7AC12A4C02251851500  vendor_dlkm_OS4.0.0.19_官方回刷.img
```

## 做了什么

本方案以官方 `.19` 完整 `vendor_dlkm` 为基底，只回移充电链相关的 28 个 KO，并把这些 KO 的导入/导出符号 CRC 适配到 `.19` ABI。其余相机、显示、USB、网络模块以及分区大小、EROFS UUID、AVB salt、FEC 和 fingerprint 均保持 `.19` 官方结构。

核心变化：

- `mca_strategy_quickchg.ko` 恢复旧版功率爬升和快充状态机。
- 去掉 `.19` 新增的循环级降 FCC、`drop_fcc_para` 和过压风险强制退出快充等软件策略。
- `bq27z561.ko` 移除 `.19` 的云端 FG 固件更新通道。
- `mca_strategy_fg_comp.ko` 移除 `smooth_new` SOC 平滑和循环相关容量策略。
- `mca_strategy_buckchg.ko` 去掉按循环次数降低浮压的路径。

SC8581、PMIC、硬件 OVP、CP、PD 认证、电池认证、JEITA 和基础温度保护没有被删除。这个项目恢复的是旧版充电策略，不是关闭全部硬件保护。

## 刷入

`vendor_dlkm` 是 `super` 内的动态分区，必须在 `fastbootd` 中写入，不能在普通 bootloader/fastboot 模式写入。

```powershell
adb devices
adb reboot fastboot
fastboot devices
fastboot getvar is-userspace
fastboot getvar current-slot
```

只有 `is-userspace: yes` 且 `current-slot: a` 才继续：

```powershell
fastboot flash vendor_dlkm_a "vendor_dlkm_米15p_4.0.19.img"
fastboot reboot
```

如果任何一步不符合预期，停止操作并重新核对版本、分区、镜像哈希和槽位。

## 回刷官方

无法开机、USB 失效、模块加载异常或充电异常时，重新进入 `fastbootd`：

```powershell
fastboot flash vendor_dlkm_a "vendor_dlkm_OS4.0.0.19_官方回刷.img"
fastboot reboot
```

不要等待系统自行修复，也不要再混刷其他版本分区。

## 验证

静态验证记录位于 [`verification/`](verification/)：

- 28 个 KO 均可解析，结果为 `modules=28 failures=0`。
- KO 的核心 `.text` 与旧版参考一致，文件大小不变。
- 只修改预期的 11 个导入 CRC 和 6 个导出 CRC。
- EROFS 回读 409 个文件，只允许 28 个充电模块变化。
- 412 项 SELinux 标签检查无异常。
- AVB footer、`NONE` vbmeta 和 SHA-256 hashtree 验证通过。
- 实机已通过 `fastbootd` 写入 `vendor_dlkm_a`，系统正常启动，分区哈希与成品一致。

可在仓库根目录或本目录执行：

```bash
python3 src/verify_release.py .
```

## 源码范围

这里的“源码”指可复现本项目的二进制分析与修补工具链：

- `src/analyze_abi.py`：解析 AArch64 KO 的 ELF、符号、导入/导出 CRC 和 modinfo。
- `src/port_modules.py`：把旧版 KO 的 CRC 适配到目标系统 ABI。
- `src/verify_port.py`：验证 `.text`、文件大小、CRC 和 vermagic。
- `src/verify_image_tree.py`：验证 EROFS 回读后只有预期模块变化。
- `src/build_oldcharge19.sh`：从官方 `.19` 镜像重建 EROFS、AVB 和最终分区。
- `src/port_oldcharge.sh`：面向后续系统版本的 CRC 重移植入口。

小米没有公开这些 KO 的完整对应内核 C 源码，因此本仓库不是“完整内核 C 源码”，也不伪造不存在的源文件。

## 重建与换系统移植

重建本版本需要 Linux/WSL、Python 3、`erofs-utils` 和 AOSP `avbtool`：

```bash
bash src/build_oldcharge19.sh \
  /path/to/official_OS4.0.0.19_vendor_dlkm.img \
  modules \
  /path/to/output \
  /path/to/avbtool
```

以后升级到其他 OS4 版本时，不能直接刷当前镜像。应先从新系统官方 `vendor_dlkm.img` 解包全部 KO，再执行：

```bash
bash src/port_oldcharge.sh \
  /path/to/old_reference_modules \
  modules \
  /path/to/new_stock_modules \
  /path/to/patched_modules
```

必须得到 `modules=28 failures=0`，之后才能用新系统官方镜像作为基底重建。详细流程见[下一次修改完整操作手册](下一次修改完整操作手册.md)。

## 风险说明

修改 `vendor_dlkm`、混用 DTBO 或错误写入动态分区都可能导致无法开机、USB 失效、基带/相机异常或只能进入特定刷机模式。请先确认自己能够通过 `fastbootd` 回刷官方分区。仓库只记录已验证的特定设备和版本结果，不承诺适用于其他设备或系统。
