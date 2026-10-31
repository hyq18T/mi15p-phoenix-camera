# 相册 2.10、AI 与调色盘合并源码

本目录基于已验证的 15 Pro 三合一 LSP（2010400），只替换作者通用 EVguard 版中的相册接口、AI 能力与 EV 保护相关类族。保留已有 15 Pro 相机修复、M3、NaturalTuning 和水印机型资产。13U 专用 AudioRecFix/Q0Fix 不启用。

## 文件

- `merged_lsp/`：实际构建的完整合并源码；57 个更新类位于 `smali_classes14`。
- `merge_meditor_update.py`：从基线解包树和作者通用版解包树重做合并，检查接口锚点和内部引用。
- `preserve_dex.py`：保留源码未改动的 dex 原字节；独立保留两个辅助 dex，避开 Apktool 解包目录冲突。
- `package_update.py`：更新二合一模块，加入官方相册编辑器，校验所有未改动载荷。
- `build_update.ps1`：PowerShell 7 重建入口；临时盘符映射到项目内，完成后自动清理。
- `java/com/prometheus/camera/meditor210/MEditor210Runtime.java`：按 2.10 的实际模型生成滤镜与调色盘参数，补最终目录和 LUT 路径；新版 AI 能力与水印/M3 检测接口。
- `compile_runtime.ps1`：编译 Java 运行接口至 `classes15.dex`。
- `patch_runtime.py`：替换作者包中残留的旧编辑器接口，并补缺失诊断方法。
- `verify_delivery.py`：最终成品的签名、载荷、版本和实机样张验证。
- `cleanup_local.ps1`：本轮缓存清理脚本。代理执行清理被自动安全审查拒绝，用户可在 PowerShell 7 运行此脚本；不删除正式成品或回退备份。

## 重建

需要现有 JDK、Python、Apktool 2.12.1 和 Build-Tools 35.0.0。

```powershell
pwsh -File 'D:\GPT\2026-09-27_小米15Pro_Phoenix相机适配\01_源码\2026-10-30_meditor210_update\build_update.ps1'
```

输入为本项目的原三合一 APK 备份、官方相册编辑器、原二合一模块和原签名密钥。脚本中的实际路径均指向本项目或已有只读工具链。输出默认位于本项目 `03_输出/2026-10-30_meditor210_update/rebuild-*`，不覆盖当前交付。

最终版本：LSP `2010503`；Magisk `2013004` / `Phoenix-1.3.0-M3-r17-MEditor210-r3`；相册编辑器 `210994308` / `2.10.43.0.8`。

升级必须复用项目现有 `allinone.keystore`。密钥不包含在源码归档或 Git 仓库中。

## 实现范围

作者的相册能力档案为 `madrid / 24069RA21C`，修改只发生在相册编辑器进程内，不改系统属性或 15 Pro 的底层相机调校。云端 AI 的实际处理仍取决于网络、账号和服务端可用性。

整合包内置相机、三合一 LSP、官方相册编辑器以及原 M3/ODM 载荷；安装器使用覆盖升级，不新增清数据操作。更高版本相册编辑器会被拒绝自动降级。

`merge_meditor_update.py` 产生初始合并树；最终 `merged_lsp` 已另外应用 `patch_runtime.py` 并提升到 `2010503`。正常重建使用 `build_update.ps1`，不要把初始合并树当作最终交付源码。

`verify_delivery.py` 的本轮执行使用项目内 ASCII 临时盘符 `V:`、`W:`，清理后需要重新映射再运行；日常重建脚本会自行寻找空闲盘符。
