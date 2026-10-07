# Phoenix（Prometheus Camera）项目调研报告

- 调研日期：2026-09-27
- 仓库：https://github.com/benbaobaoshigemi/Prometheus-Camera
- 调研版本：Phoenix V1.3.0（tag V1.3.0，发布于 2026-09-26）
- 默认分支：`Phoenix`（注意：不是 `main`，`main` 上是旧的短 README）

## 1. 项目定位

Phoenix 不是一个独立 App，而是一套"改机包"，由三部分协作，作用对象是小米官方相机 `com.android.camera`：

| 部分 | 权威输入 | 运行职责 |
| --- | --- | --- |
| Camera | 官方 APK + `camera/patch/` | 重打包官方相机，提供界面、拍摄流程、资源与基础能力 |
| LSP | `lsp/` | 在相机、相册编辑器等目标进程中提供扩展逻辑（Xposed hook） |
| 根模块 | `module/` | 安装 APK、挂载 ODM 资产、初始化应用私有文件与后台同步 |

授权：自有代码与有权授权的修改为 `GPL-3.0-only`；相机补丁、LSP、模块资产含第三方内容，保留各自许可（见 `third-party.json`），不因项目 GPL 声明统一改授。

## 2. 版本线（重要，容易误判）

同一个仓库存在三代互不连续的版本号：

- `V2.0` ~ `V5.1`（2026-07）：旧的 Prometheus Camera 时代，产物为 `Prometheus_Cam_*.apk` / `Prometheus_Module_*.zip` / `Prometheus_Project_*.zip`。
- `NRV-1.3.2`、`NRV-1.5.0`（2026-08）：另一条独立线，产物命名 `Prometheus_*_NRV-*.apk`。
- `V1.0.0` → `V1.1.0` → `V1.3.0`（2026-09 起）：Phoenix 时代，版本号被重置。当前正式版为 **V1.3.0**。

V1.3.0 的 7 个发布附件：

| 附件 | 大小 | 下载数 | 说明 |
| --- | --- | --- | --- |
| `Phoenix_Phoenix-1.3.0_AllInOne.zip` | 202.29 MB | 226 | Camera + LSP + 根模块整合包 |
| `Phoenix_Camera_Phoenix-1.3.0.apk` | 212.12 MB | 77 | 移植后的相机 APK |
| `Phoenix_LSP_Phoenix-1.3.0.apk` | 12.43 MB | 56 | LSPosed 扩展 APK |
| `Phoenix-1.3.0-source.zip` | 96.46 MB | 87 | 可重建源码与工具（不含官方底包、不含签名私钥） |
| `PhoenixAddon-AUTHVignette-V1.1.0-Package.zip` | 0.49 MB | 22 | 独立暗角 Addon |
| `PhoenixAddon-AUTHVignette-V1.1.0-Source.zip` | 0.03 MB | 5 | 暗角 Addon 源码 |
| `PhoenixAddon-AUTHVignette-V1.1.0-Reference.zip` | 极小 | 9 | 参考材料 |

另有独立发布的 `PhoenixAddon-LegendM3 V1.0.0`（tag `legend-m3/v1.0.0`，2026-09-14，Package 14.84 MB / 下载 604）。

## 3. 功能清单（README 明确列出）

- 普通视频模式的 Leica Looks 选择器。
- 专业录像中两个世代的滤镜 / LUT 入口。
- 电影画幅与滤镜快门抽动修复。
- 普通徕卡经典风格管理、自定义 LUT 与滤镜资产同步。
- "小米ASD"开关：默认遵循相机原生状态，手动切换后固定开启或关闭并保存。
- 本地水印、色卡与签名模板，以及 by Leica、Leitz 机型水印。
- 独立的"图片元数据"和"水印元数据"写入开关。
- 相机备份 / 恢复适配。
- 徕卡经典暗角着色器（独立 AUTHVignette Addon，不随主包安装）。
- "柔光控制"快捷组件（实验室选项）。

**明确不支持：徕卡一瞬**（不应与徕卡经典、自定义滤镜、水印混同）。

## 4. 构建链路

工具环境要求：Python 3.11+（脚本只用标准库）、JDK 17（`java`、`keytool` 可调用）、Apktool 2.12.1、Android SDK Build-Tools 35.0.0。构建在 Windows 11 上验证过。

```
python tools/bootstrap.py                                     # 下载固定版本 Apktool 到 tools/vendor/
python tools/build_phoenix.py --camera-apk "D:/camera/new.apk" # 全量构建
python tools/build_phoenix.py --mode camera --camera-apk ...   # 只构建相机
python tools/build_phoenix.py --mode lsp                       # 只构建 LSP（不需要官方相机 APK）
```

产物输出到 `dist/Phoenix-1.3.0/`；`work/` 保存解包树、编译缓存与本地开发密钥（`work/keys/development.keystore`，别名 `androiddebugkey`，密码 `android`）。

签名策略：
- Camera APK 使用**官方底包的 OEM Signing Block**（搬运签名块不等于获得有效小米签名，无法通过标准官方签名验证）。
- LSP 用 `apksigner` 签名并验证；持续更新已安装 LSP 必须使用与已安装版本相同的密钥。

## 5. 底包硬校验（适配的关键约束）

`tools/build_phoenix.py` 的 `build_camera()` 每次构建都计算输入 APK 的 SHA-256，与 `supported-camera.json.sha256` 比较，**不匹配直接抛 `Unsupported camera APK; see supported-camera.json`**。

| 字段 | 值 |
| --- | --- |
| 来源 | 小米 17 Ultra OS4 官方相机 |
| 包名 | `com.android.camera` |
| versionName | `6.6.000510.0` |
| versionCode | `660005100` |
| 大小 | `193895068` 字节 |
| SHA-256 | `6bf98a86a8e6090b86cf41cb178ef44512171503d3edb685e2564954af47b662` |
| Apktool | `2.12.1` |

官方完整 APK **不包含**在源码仓库和源码 ZIP 中，构建时必须通过 `--camera-apk` 自行提供。

`AI_CONTEXT.md` 明确指出：适配新底包"涉及重新建立补丁、类映射、资源与运行验证，**不能仅修改摘要配置来完成**"。

## 6. 补丁机制（`camera/patch/`）

`camera/patch/` 是一份完整的 Apktool 反编译树：`apktool.yml` + `AndroidManifest.xml` + `smali/` + `smali_classes2~6` + `res/` + `assets/`。

清单文件 `camera/patch/patch.json`（162,708 字节）实际规模：

- `entries`：**1127** 条
- `deletions`：**15** 条
- `deletedClasses`：**14** 条
- 顶层键：`format`、`entries`、`deletions`、`deletedClasses`

`entries` 的 `targetPath` 前缀分布：

| 目标前缀 | 条数 |
| --- | --- |
| `res` | 560 |
| `smali` | 284 |
| `assets` | 156 |
| `smali_classes3` | 75 |
| `smali_classes10` | 36 |
| `smali_classes2` | 12 |
| `smali_classes4` / `smali_classes5` / `smali_classes6` | 各 1 |
| `AndroidManifest.xml` | 1 |

合计 smali 类替换 **410** 个。

合并算法 `patched_files()` 的顺序：

1. 读取官方解包树，建立 **smali 类描述符 → 文件路径** 索引。
2. 处理 `deletions`；smali 删除项用 `deletedClasses` 的类描述符定位真实文件，其他资源按路径删除。
3. 处理 `entries`；已有 smali 类**按 `.class` 描述符替换**（因此混淆类名改名不影响匹配），新增类路径冲突时改用 `.phoenix.smali` 后缀；非 smali 按 `targetPath` 直接落位。
4. 强制使用补丁目录的 `apktool.yml` 作为最终编译配置，并覆盖其中 versionName / versionCode。

要点：smali 的身份由 `.class` 声明决定，文件名不一定等于类名（Windows 大小写不敏感，解包文件可能带 `.1` 后缀）。**`entries` 才决定哪些补丁文件被应用**，单独把文件放进目录不生效。

> 文档漂移提示：`AI_CONTEXT.md` 写"1,077 个应用条目"，实际 `patch.json` 已是 1127 条。以实际 JSON 为准。

## 7. LSP 入口

`lsp/assets/xposed_init` 列出三个加载入口：

- `com.prometheus.camera.rev.CombinedEntryPoint`
- `com.prometheus.camera.colordev.EntryPoint`
- `com.prometheus.camera.rev.FeatureEntryPoint`

| 功能 | 主要定位类 |
| --- | --- |
| OS4 相机扩展与水印发布 | `CameraV51Bridge` |
| 机型名称消费者与元数据写入 | `CameraWatermarkBridge` |
| 水印位图与 MIVI JSON 变换 | `WatermarkAssetRouter` |
| 机型选择与元数据开关 | `DeviceNameOverride`、`MetadataSyncPreferenceFragment` |
| 扩展设置界面 | `com.prometheus.camera.settings` 包及 `lsp/res/` |

LSP 的完整可编译输入是 **smali 与资源**；`tools/feature_sources/` 下的 Java 只是可读参考。

## 8. 模块与资产

模块 ID 为 `legend17u_14u_local`（来自 `module/module.prop`，显示名 "Phoenix Camera - Xiaomi 14 Ultra"），安装后位于 `/data/adb/modules/legend17u_14u_local/`。

ODM 挂载只针对两个子树（**不挂载整个 `/odm`**）：

| 挂载目标 | 内容 |
| --- | --- |
| `/odm/etc/camera/videofilter` | 视频滤镜资产，ROM 原有项与模块项合并 |
| `/odm/etc/camera/xiaomi/watermark` | 水印资产，构建合并子树后递归 bind mount |

`post-fs-data.sh` 为上述内容设置 SELinux 标签 `u:object_r:vendor_configs_file:s0`。

`service.sh` 顺序：等待 `lspd` / LSP 包路径 / LSPosed 数据库（最多约 120 秒）→ 调用 `ScopeInstaller` 配置相机、相册编辑器、系统框架作用域 → 等待应用数据目录后执行 `seed-watermark.sh` → 启动 LUT / by Leica / 本地水印同步 → 每 30 秒同步水印后缀。

故障定位日志：`install-audit.log`、`mount.log` / `mount_failed`、`开机日志.txt`、`LSPosed作用域详情.txt`、`watermark-cache.log`。

## 9. 前置环境与硬性要求

| 项目 | 要求 |
| --- | --- |
| 系统 | 完美支持澎湃 OS3；理论上支持澎湃 OS4 |
| 机型 | 理论上支持所有搭载澎湃 OS3 的 LEICA 联名直板机型 |
| 根管理器 | 理论上支持 KernelSU、Magisk、APatch |
| **必备环境** | **ROOT + LSPosed + 核心破解，三者缺一不可** |
| 相册注入 | "小米相册-编辑"必须为 **2.4.0.4.3** |
| 安装生命周期 | 安装前清除"相机"和"小米相册-编辑"应用数据；安装后**严禁**再清除 |

`customize.sh` 会检查 `com.miui.mediaeditor` 是否存在，缺失直接拒绝刷入。

## 10. 验证状态（作者自述，务必重视）

来自 `verification.json`：

- `deviceValidation`: **"not performed for 1.3.0"** —— 1.3.0 **没有做过真机验证**。
- 1.3.0 相对 baseline `Phoenix-1.2.17` 只做了**离线比对**：Camera 仅 `AndroidManifest.xml` 变化（smali 解码后相等、签名块相等）；LSP smali 解码相等、签名证书与 1.2.17 相同；模块静态文件除版本外相等。
- `sourceArchiveRebuild`：源码 ZIP 在干净目录重建通过，APK 条目名与 CRC 匹配（整体字节因打包/签名元数据不可重现而不同）。
- KernelSU 已完成实际安装与开机验证；Magisk、APatch 仅通过设备隔离测试，**实际管理器安装与开机兼容性待验证**。
- 唯一实机验证设备为小米 14 Ultra（`aurora`）。

## 11. 已知限制

- **小米 14 Ultra 之前的机型，"徕卡经典风格切换"功能失效。**（15 Pro 比 14 Ultra 新，原则上不落在这条限制内，但仍需实测。）
- 开启"图片元数据"会影响人像照片在相册中重新编辑虚拟光圈；需要重编辑时须在拍摄前关闭，关闭不会自动修复已拍照片。"水印元数据"是独立选项，处理该问题不要求关闭它。
- 暗角 Addon 调整的是经典后处理中的一个着色器节点，0% 不代表消除传感器及其它处理阶段形成的全部暗角。
- 成片库以小米 14 Ultra 原库为基础构建，不同机型成片兼容性仍需实机测试。

## 12. 小米 15 Pro 适配可行性分析

适配分两条路线，取决于 15 Pro 上官方相机的版本。

### 路线 A：复用现有底包（轻量）

前提：15 Pro 能运行官方相机 `6.6.000510.0`（即 17 Ultra OS4 那版）。

Phoenix 本身就是"用 17 Ultra 的相机底包 + 针对 14 Ultra 适配"的产物，所以跨机型复用同版本底包是该项目的既有做法。此时需要处理的是**机型相关**部分：

- `module/module.prop` 的 `name` / `description`（当前写死 "Xiaomi 14 Ultra"）。
- `DeviceNameOverride` 的机型水印标识（偏好键 `watermark_device_name`）。
- `module/system/odm/etc/camera/` 下的 ODM 资产（只涉及 videofilter 与 watermark 两个子树，不是整机 camera tuning，风险相对可控）。
- 构建出的 Camera APK 版本号（`version.json`）。

### 路线 B：重新适配底包（重量）

如果 15 Pro 的相机版本不是 `6.6.000510.0`，则必须重新建立补丁：410 个 smali 类映射、560 个资源条目、15 个删除项、14 个类删除，全部需要在新底包上重做并实机验证。作者已明确说明这不能靠改摘要完成。工作量与风险都很大。

### 现实判断

- 15 Pro（`haotian`，LEICA 联名）在作者声明的"理论上支持"范围内，但**从未被实测**。
- 真正决定难度的只有一个问题：**15 Pro 当前官方相机版本号是多少，以及能否装上 / 是否就是 6.6.000510.0**。
- 关键风险点是 ODM 资产与成片库（`libMiPhotoFilter.so`）以 14 Ultra 原库为基础，15 Pro 传感器组合不同（15 Pro 为 LYT-818 主摄 + 5x 潜望），需实机确认滤镜/水印链路是否正常。

## 13. 待确认信息（阻塞项）

需要 15 Pro 实机（无线 ADB）确认：

1. 机型代号与 HyperOS 版本（OS2 / OS3 / OS4）。
2. 官方相机 `com.android.camera` 的 versionName / versionCode / APK 大小。
3. 是否已有 ROOT + LSPosed + 核心破解。
4. "小米相册-编辑"（`com.miui.mediaeditor`）版本。
5. 能否提供 / 是否已持有 `6.6.000510.0` 的官方相机 APK。

## 14. 参考资料

- 仓库：https://github.com/benbaobaoshigemi/Prometheus-Camera
- V1.3.0 发布页：https://github.com/benbaobaoshigemi/Prometheus-Camera/releases/tag/V1.3.0
- 上游关键文档：`README.md`、`AI_CONTEXT.md`、`CHANGELOG.md`、`verification.json`、`supported-camera.json`、`vignette-shader.md`（已存于本项目 `01_源码/_upstream/`）
