# PhoenixAddon-LegendM3

当前版本：**V1.0.0**

> 本仓库已移除旧版 `release/PhoenixAddon-LegendM3-V1.0.0-Package.zip`（14 Ultra 原版可刷面具模块）。
> 小米 15 Pro 请使用 `成品/PhoenixAddon-LegendM3-V2.0.0-15Pro-Module-r17-final.zip`（模块 ID 同为 `phoenix_m3`，属同模块的新版本，不能与旧版共存）。

PhoenixAddon-LegendM3 为 Phoenix 提供徕卡经典 M3 成像链路。Addon 使用独立版本号；升级时保持 APK 包名 `com.phoenix.camera.m3` 与根模块 ID `phoenix_m3`，可覆盖安装同一 Addon 的旧版本。

## 下载

| 文件 | 内容 |
| --- | --- |
| ~~`PhoenixAddon-LegendM3-V1.0.0-Package.zip`~~（**已移除**） | 旧版正式交付包（14 Ultra 原版，含旧 `phoenix_m3` 面具模块）。为避免误刷导致降级，已从本仓库删除；小米 15 Pro 请用 `成品/PhoenixAddon-LegendM3-V2.0.0-15Pro-Module-r17-final.zip` |
| [`PhoenixAddon-LegendM3-V1.0.0-Source.zip`](release/PhoenixAddon-LegendM3-V1.0.0-Source.zip) | 可下载的源码归档，与 [`source/`](source/) 内容一致 |
| [`PhoenixAddon-LegendM3-V1.0.0-Reference.zip`](release/PhoenixAddon-LegendM3-V1.0.0-Reference.zip) | 完整移植说明、14 Ultra 适配方法、相册兼容说明和结构化证据 |

## 功能

- 接入徕卡经典 M3 的相机入口、请求元数据与成片处理链路。
- 移植 M3 的 AEC、LTM、ASF、暗角及相关 tuning，并完成小米 14 Ultra 各摄像头的映射。
- 修复 2:3 成片几何、快速变焦、暗角着色器参数和水印回撤链路。
- 支持“小米相册-编辑”2.4.0.4.x 与 2.4.0.5.x 的 M3 后处理入口。
- 修复 JPEG 中向后指向的 EXIF Interop IFD，避免相册无法完成 M3 分类、加载和回撤；有效的向前 Interop 指针保持不变。
- 安装与升级时刷新相关相册缓存，避免旧的解析结果继续生效。

## 安装范围

当前版本面向小米 14 Ultra 的 Phoenix 环境。安装正式交付包内的 KernelSU 模块和 LSPosed APK，并在 LSPosed 中勾选相机与“小米相册-编辑”作用域。安装细节、文件布局和验收步骤见正式交付包内 README。

向其他机型移植时，应按参考包中的方法重新建立传感器、镜头、Mivi ABI、AEC、LTM、ASF 和几何映射；不能直接沿用 14 Ultra 的 cameraId、sensorId、裁切和 tuning 选择。

## 校验

| 文件 | SHA-256 |
| --- | --- |
| ~~`PhoenixAddon-LegendM3-V1.0.0-Package.zip`~~（已移除，SHA 仅作历史记录） | `7F28D9E5C3EFB21FA493AFF18BF75664BB1DC9A4ADFF41C74F3DCB42FA63A18C` |
| `PhoenixAddon-LegendM3-V1.0.0-Source.zip` | `0917D684D11B115691624CDD6C4B5BD44BD5F2E9605368C71FDCB87C72E8FD9D` |
| `PhoenixAddon-LegendM3-V1.0.0-Reference.zip` | `8A71B1C6C7D833CCC6BE0737C71552D5E7E50164D45800CF11D64E29CBD50C38` |

源码和参考包均带逐文件 `manifest.json`。源码不包含签名私钥、目标 ROM、官方相机 APK 或供体二进制。
