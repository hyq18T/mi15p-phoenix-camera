# Phoenix 15 Pro 相机+M3 二合一交付清单

交付日期：2026-10-18

## 成品

| 文件 | 大小 | SHA-256 |
| --- | ---: | --- |
| `Phoenix_15Pro_Camera_M3_AllInOne-1.3.0.zip` | 227,802,709 B | `9AD91E3FF6F673C241CC6C4CF753C20E7C8AFCEF5E0200042D159E266EE6EF87` |

包内关键组件：

| 组件 | 版本 / 说明 | SHA-256 |
| --- | --- | --- |
| `Phoenix_Camera_Phoenix-1.3.0.apk` | 相机 APK | `9FAFF5BFFDB03E9EDCA953E091C3812B7E6D365510CE08061196F89131334AF6` |
| `Phoenix_LSP_AllInOne-1.3.0.apk` | LSP versionCode `2010400` | `2C22FB119F8ADDDDEB703EAAC0EF2D63BD22E3D74B3CF5E0A531B5370C7C58B0` |

## 合并内容

- 原 `phoenix_camera_15pro`：相机 APK、AllInOne LSP、滤镜、水印、ODM 资产和同步脚本。
- 原 `phoenix_m3`：徕卡一瞬 M3 配置、插件、AEC runtime、aux relay 和快照资源。
- 新模块统一由 `post-fs-data.sh` 先挂 M3、再挂相机；`service.sh` 先启动 M3 服务、再启动相机服务。

## 实机验证

| 项目 | 结果 |
| --- | --- |
| Magisk 模块数量 | 只剩 `phoenix_camera_15pro` |
| 旧 `phoenix_m3` | 重启后自动移除 |
| `mount-all.log` | M3 `status=0`，camera `status=0` |
| `videofilter` | 69 个文件，0 个空文件 |
| `watermark` | 108 个文件，0 个空文件 |
| M3 入口 | 「更多」→「徕卡一瞬」可进入 |
| M3 预览 | `preview rendered` 正常，无崩溃 |
| M3 实拍 | `IMG_20261018_185211.jpg`，8,374,807 B |
| LSPosed | `PhoenixM3`、`PhoenixNatural15Pro`、主 LSP 均加载 |

验证证据位于 `验证证据/`：

- `M3入口-预览正常.png`
- `M3实拍后-缩略图已更新.png`
- `M3实拍-IMG_20261018_185211.jpg`
- `LSPosed-M3-AllInOne.log`
- `mount-all.log`、`mount-m3.log`、`mount-camera.log`
- `module.prop.device`

## 说明

本轮只做 Magisk 模块封装合并，没有重新构建相机 APK，也没有改动上一版相机/LSP 的成像逻辑。上一版已经存在的相机功能与已知问题保持不变。
