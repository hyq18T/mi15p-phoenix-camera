# Phoenix Camera · 小米 15 Pro 二改（槐蔭區2改）

把上游 [Prometheus-Camera / Phoenix](https://github.com/benbaobaoshigemi/Prometheus-Camera) 的 Phoenix 1.3.0 适配到小米 15 Pro（`haotian` / `2410DPN6CC`），并保留已验证的相机、徕卡一瞬 M3、NaturalTuning 与相册编辑器扩展。

> 二改署名：槐蔭區2改　｜　上游：`benbaobaoshigemi/Prometheus-Camera`（GPL-3.0-only）

## 当前推荐版本

当前推荐使用 2026-10-30 的 MEditor210 整合版：

| 文件 | 用途 |
| --- | --- |
| `成品/Phoenix_15Pro_Camera_M3_MEditor210_AllInOne-1.3.0.zip` | 推荐 Magisk 整合包，包含相机、相册编辑器 2.10.43.0.8、三合一 LSP 与 M3/ODM 资产 |
| `成品/Phoenix_LSP_AllInOne-MEditor210-1.3.0-15Pro.apk` | 独立三合一 LSPosed 模块，versionCode `2010503` |
| `成品/MediaEditor_2.10.43.0.8.apk` | 官方相册编辑器，versionCode `210994308` |
| `成品/Phoenix_15Pro_MEditor210_Source.zip` | 本轮源码归档，不含签名私钥 |

正常使用只刷整合包即可；它已经包含相机、相册编辑器、三合一 LSP 和 M3/ODM 资产。只有需要单独回退或调试时，才使用独立 APK。

## 已验证功能

- 42 个 Phoenix 滤镜预设及正确名称。
- 滤镜调色盘的饱和度、影调调整与保存出图。
- AI 超清实际处理与保存出图。
- 徕卡一瞬 M3 预览与实拍。
- 15 Pro 相机的 EV、夜景经典风格、实况运镜和超清实况修复。

其他云端 AI 入口已开放，但实际出图仍取决于账号、网络、资源下载和服务端状态，未逐项验收。

## 安装要求

- 小米 15 Pro（`haotian`），ROOT、Magisk、LSPosed 和核心破解环境。
- 相机功能基于项目已验证的官方相机底包 `6.6.000510.0`。
- 不要清除相机或相册编辑器数据；整合包采用覆盖升级。
- 如果手机已有更高版本相册编辑器，整合包不会强制降级。

## 安装方式

1. 在 Magisk 中刷入 `成品/Phoenix_15Pro_Camera_M3_MEditor210_AllInOne-1.3.0.zip`。
2. 重启手机并解锁一次。
3. 确认 LSPosed 保持启用；整合包会自动安装相机、编辑器和三合一 LSP。

不需要另外刷旧版相机模块、旧版 M3 模块或旧版 NaturalTuning APK。旧成品已从本仓库移除，避免误刷降级。

## 本二改包含的主要适配

- 机型标识、模块名称和水印资产改为小米 15 Pro。
- 修复 `/odm` 资产挂载、夜景徕卡经典出绿、超清/夜景/人像 EV 入口。
- 修复实况运镜的 EIS、片尾回程和 5x 物理切镜头问题。
- 补齐超清实况与徕卡一瞬的档位资产；红毯预设因 15 Pro HAL 缺少 `enableMasterLivePhoto`，当前按兼容策略移除。
- 将相册编辑器更新到 2.10.43.0.8，加入 Phoenix 滤镜、调色盘、AI 超清和相关检测接口。

## 源码目录

```text
camera/                 相机 APK 外挂补丁
lsp/                    原三合一 LSP 源码
lsp-allinone/           LSP 合并脚本与解包源码
module/                 Magisk 模块源码和资产
addons/                 M3、NaturalTuning 等附加源码
tools/                  原项目构建工具
源码/meditor210_update/ 相册 2.10 更新的最终合并源码与重建脚本
文档/                   适配、验证和回退说明
成品/                   当前交付文件
```

源码归档不包含官方底包、签名私钥或 `allinone.keystore`。重建 MEditor210 版本需要 JDK、Python、Apktool 2.12.1、Android Build-Tools 35.0.0，以及项目内既有回退输入。

## 已知限制

- 红毯运镜入口因 15 Pro HAL 硬缺 `enableMasterLivePhoto` 暂不恢复。
- 17U 到 15 Pro 的 DRC 全链字段映射尚未收敛，本仓库没有把未验证的整链移植标成已完成。
- 云端 AI 和各种水印模板未逐项做长时间日常测试。

## 许可证与免责声明

上游代码按 GPL-3.0-only 发布；第三方滤镜、水印、字体和官方 APK 的权利归各自权利人。仅供个人学习和自用，刷机前请自行备份并确认可以回退。
