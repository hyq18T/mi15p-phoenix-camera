# Phoenix 1.3.0

## 2026-10-30 MEditor210 更新

- 新增官方相册编辑器 `2.10.43.0.8`，versionCode `210994308`。
- 新增 MEditor210 三合一 LSP，versionCode `2010503`。
- 新增相册 42 个 Phoenix 滤镜预设、名称修复、调色盘保存和 AI 超清保存链路。
- 新增 `Phoenix_15Pro_Camera_M3_MEditor210_AllInOne-1.3.0.zip` 整合包与可重建源码归档。
- 清理被新版取代的旧相机 APK、旧 LSP APK、旧整合包和旧 NaturalTuning 成品，避免重复和误刷降级。
- 保留相机、M3、NaturalTuning、EV 和实况运镜的已验证适配；未把未验证的 17U DRC 整链移植描述为已完成。

- 新增小米 15 Pro 相机 + 徕卡一瞬 M3 二合一 Magisk 模块。
- 新增主 LSP + M3 + NaturalTuning 三合一 LSPosed 模块。
- 新增 NaturalTuning v1.4.0 的 15 Pro 适配源码与成品。
- 二合一模块内置相机 APK 与 AllInOne LSP，刷入后旧 `phoenix_m3` 自动移除。
- 合并已验收的徕卡经典/生动入口与专业视频滤镜注入修复。
- 纳入电影画幅、滤镜快门抽动和备份/恢复适配。
- Camera、LSP、模块版本统一为 1.3.0；同步可重建源码包。
- 清理旧 M3 单独模块、旧 M3 LSP、旧主 LSP 与旧 AllInOne 成品，成品目录只保留最新交付。

以下为历史 1.1.0 记录。

## Phoenix 1.1.0

Phoenix V1.1.0，延续 V1.0.0 发布线的正式迭代。

## 1. 维护

- 修复了日志乱拉屎的问题。
- 修复了 Magisk 面具下的若干问题，包含水印链路异常。
- 更换了“徕卡经典风格”的“中性”LUT，更还原光感和色彩。
- “关闭小米ASD”改为“小米ASD”，读取原生状态作为默认值，手动切换后强开或强关，并保留选择。

## 2. 柔光控制

- 新增“柔光控制”快捷组件，可以在拍照页面快速控制柔光模拟效果，体验遥遥领先于小米官方，对标 OPPO！

## 3. 徕卡经典暗角着色器调节

- 新增徕卡经典暗角着色器调节功能，可以根据自己的喜好调节暗角的程度与范围，也支持关闭暗角。
- 支持关闭原厂徕卡经典暗角算法的高光保护，以更贴合物理暗角效果。
- 支持关闭原厂徕卡经典暗角算法的形状变换。原厂把暗角变换成了 4:3 的椭圆，但是这明显是背离物理效果的。
- 新增实验室功能：支持将自己写的 GLSL 着色器上传到徕卡经典暗角节点里面应用，实现各种神秘效果，包含毒蘑菇色散（着色器文件已作为附件上传）。

## 下载与使用

- `Phoenix_Phoenix-1.1.0_AllInOne.zip`：整合安装包，包含 Camera、LSP 和根模块。
- `Phoenix-1.1.0-source.zip`：可构建源码、工具和文档，不含官方相机底包与签名私钥。
- `chromatic.glsl`：毒蘑菇色散着色器。在“徕卡经典暗角着色器”的实验性功能中导入并启用。

从 Phoenix 1.0.x 升级请保留应用数据，刷入整合安装包后按安装器提示重启。首次安装、前置环境和已知限制请阅读[使用说明](https://github.com/benbaobaoshigemi/Prometheus-Camera/blob/V1.1.0/README.md)。

[源码](https://github.com/benbaobaoshigemi/Prometheus-Camera/tree/V1.1.0) · [着色器说明](https://github.com/benbaobaoshigemi/Prometheus-Camera/blob/V1.1.0/vignette-shader.md) · [验证记录](https://github.com/benbaobaoshigemi/Prometheus-Camera/blob/V1.1.0/verification.json)
