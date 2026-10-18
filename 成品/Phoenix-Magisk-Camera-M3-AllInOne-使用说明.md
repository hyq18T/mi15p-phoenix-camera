# Phoenix 15 Pro 相机+M3 使用说明

适用机型：小米 15 Pro（`haotian`）

## 作用

这是一个 Magisk 二合一模块，把原来的相机模块和 M3 模块合并为一个：

- 相机滤镜、水印和 ODM 资产
- 徕卡一瞬 M3、插件和 AEC runtime
- 自动安装相机 APK 与 Phoenix LSP AllInOne

模块 ID：`phoenix_camera_15pro`

模块版本：`Phoenix-1.3.0-M3-r17`

## 安装

1. 在 Magisk 中刷入 `Phoenix_15Pro_Camera_M3_AllInOne-1.3.0.zip`。
2. 刷入完成后直接重启，不要清除相机或相册数据。
3. 重启后 LSPosed 会自动勾选所需作用域。
4. 首次进入相机后，在「更多」里确认能看到「徕卡一瞬」和「实况运镜」。

如果设备上还有旧的 `phoenix_m3` 模块，刷入本包时会被自动标记移除，重启后 Magisk 中只保留 `phoenix_camera_15pro`。

## 已验证

- Magisk 中只剩一个 Phoenix 相机相关模块。
- 相机 M3 挂载状态 `0`，相机模块挂载状态 `0`。
- `/odm/etc/camera/videofilter` 69 个文件、`watermark` 108 个文件，均非空。
- 「徕卡一瞬」入口可进入，M3 预览正常渲染。
- M3 实拍成功，生成 `IMG_20261018_185211.jpg`（8,374,807 B）。
- LSPosed 日志确认 `PhoenixM3`、`PhoenixNatural15Pro` 和主 LSP 均从 AllInOne 包加载。

## 回档

相机单模块回档包：

`04_交付/Phoenix-1.3.0-15Pro-最新三件套-20261007/`

独立 M3 回档包：

`04_交付/LegendM3-V2-15Pro-r17-final-20261004/PhoenixAddon-LegendM3-V2.0.0-15Pro-Module-r17-final.zip`

注意：回档前先卸载当前二合一模块，再刷回对应旧包，避免两个模块同时挂载同一批 ODM 文件。
