# 小米 15 Pro 机型标识修改与兼容性审计

日期：2026-09-28
对象：Phoenix 1.3.0（Prometheus Camera）× Xiaomi 15 Pro（`haotian` / `2410DPN6CC`，澎湃 OS3.0.309.0）
产物：`04_交付/Phoenix-1.3.0-15Pro/`
文中行号以构建沙箱 `D:\GPT\_phoenix_build` 的工作副本为准。

---

## 1. 本次改了哪 4 处

| # | 文件 | 原值 | 新值 |
| --- | --- | --- | --- |
| 1 | `module/module.prop` | `id=legend17u_14u_local` | `id=phoenix_camera_15pro` |
| 2 | `module/module.prop` | `name=Phoenix Camera - Xiaomi 14 Ultra` | `name=Phoenix Camera - Xiaomi 15 Pro` |
| 3 | `module/module.prop` | （描述未提机型） | description 末尾补「本包按 Xiaomi 15 Pro（haotian）适配。」 |
| 4 | `lsp/smali_classes2/com/prometheus/camera/settings/WatermarkAssetRouter.smali:64` | `const-string v1, "14 Ultra"` | `const-string v1, "15 Pro"` |
| 5 | `lsp/assets/prometheus/watermark-suffix/111/mivi_1..37.json:159`（37 个文件） | `"text": " 14 Ultra"` | `"text": " 15 Pro"` |
| 6 | `lsp/smali_classes2/com/prometheus/camera/settings/DevicePresetStore.smali:13-47` | 机型预设 6 项，无本机 | 追加第 7 项 `15 Pro`（`FIXED_VALUES` / `FIXED_LABELS` 同步） |

第 6 项补 `.locals 7` → `.locals 8`，数组用 `filled-new-array/range {v0 .. v6}`，`move-result-object v7`。
`DevicePresetStore.fixed()` 与 `DeviceNamePreferenceFragment` 的渲染循环都用 `array-length` 取长度（`DevicePresetStore.smali:300`、`DeviceNamePreferenceFragment.smali:155-174`），**没有硬编码项数**，追加是安全的。

### 1.1 为什么"模块名"和"水印机型名"是两回事

- 第 1～3 项只影响 **Root 管理器模块列表里显示的那一行**（你在 Magisk / KernelSU 里看到的 "Xiaomi 14 Ultra" 就是它）。运行时脚本全部用 `$MODDIR`/`${0%/*}` 定位自己，没有任何脚本硬编码旧模块目录名（已全量 grep 确认），所以改 `id` 不会破坏安装逻辑。
  - 副作用提醒：`id` 变了 = 模块身份变了。**若设备上还装着旧 id 的模块，必须先卸载再刷，否则会出现两个模块同时挂 ODM。**（本机 2026-09-28 实查 `/data/adb/modules/` 内没有旧模块，无残留。）
- 第 4～5 项才是**成片上真正印出来的机型名**，链路是：

```
SharedPreferences("prometheus_camera_settings").getString("watermark_device_name", <默认值>)
        │                     ← 第 4 项改的就是这个默认值
        ▼
WatermarkAssetRouter.activeName(ctx)                    WatermarkAssetRouter.smali:50-71
        ▼
WatermarkAssetRouter.postProcessMivi(ctx, src, dst)     WatermarkAssetRouter.smali:947
        ├─ 名字 == "leitzphone powered by xiaomi" → ensureLeitzAssets()
        ├─ DeviceNameRouting.isLeica(名字) == false → **直接 return，不做任何替换**
        └─ 否则 ensureSuffixAssets() 并把模板里的 model 节点改写成 baseName(名字)
```

**关键点**：`DeviceNameRouting.isLeica()` 只认 `(?i).*\sby\sleica$` 结尾的名字（`DeviceNameRouting.smali:222-236`）。默认值 `15 Pro` **不含** " by Leica"，所以 `postProcessMivi` 会**原样返回、不动模板**——也就是说 **`mivi_*.json` 里那行静态文本才是实际印到水印上的字**。两处必须一起改，只改一处不生效。本次两处都改了。

---

## 2. 15 Pro 真机硬件事实（本次实测，非推测）

采集：`adb shell dumpsys media.camera`（2.1 MB 原始 dump 已解析）

| 物理摄像头 | 35 mm 等效焦距 | 光圈 | 朝向 |
| --- | --- | --- | --- |
| 主摄 | 23.0 mm | **f/1.44（`availableApertures` 只有 1 个值）** | BACK |
| 超广角 | 14.0 mm | f/2.20 | BACK |
| 潜望长焦 | 120.0 mm | f/2.50 | BACK |
| 前置 | 21.8 mm | f/2.00 | FRONT |
| 其余 device 7/8 | — | — | EXTERNAL |

补充：`ro.product.marketname` = `Xiaomi 15 Pro`；`ro.product.mod_device` = `haotian`。
**结论：15 Pro 是后置三摄（14 / 23 / 120 mm），主摄为固定光圈，没有 75 mm（3.2×）镜头，也没有可变光圈。**

---

## 3. 兼容性审计：逐项结论

### A. 必须改，已改
见第 1 节。

### B. 看着像"14 Ultra"，但**不能改**（改了会坏）

| 位置 | 值 | 为什么不能改 |
| --- | --- | --- |
| `lsp/smali/com/prometheus/camera/rev/CameraWatermarkBridge.smali:7`、`:116` | `NATIVE_LEICA_MODEL = "17 Ultra by Leica"` | 它是**底包（17 Ultra OS4 相机）自己的原生机型串**，`captureSelection()` 用它来判断"当前选中的是不是底包原生徕卡机型"，从而决定要不要把名字压成 `baseName()`。这是**识别底包的锚点**，不是目标机型的名字。改成 15 Pro 会让识别逻辑永远不成立。 |
| `lsp/smali_classes2/.../WatermarkAssetRouter.smali:11` | `OFFICIAL_LEICA_ASSETS = "cloud_watermark_material/17_ultra_by_leica/"` | 底包 APK 内的**素材目录路径**，改了会找不到官方徕卡水印素材。 |
| `lsp/smali_classes2/.../OnlineLeicaRenderer.smali:43`、`:972` | `REFERENCE_TEXT = "17 Ultra"` | 只用于 `Paint.measureText()` 的**排版基准宽度**（`OnlineLeicaRenderer.smali:968-980` 拿它算居中偏移）。与机型身份无关，改了水印会跑偏。 |
| `lsp/smali_classes11/com/nezha/q0fix/`（`PhoenixQ0Fix.smali:197-211`） | `Songyuan / Nezha / Changan… / Chagall_gl / Warhol_gl / Xuanyuan / Byron / Athens` | 这是 17 Ultra 底包的**设备配置（DeviceFactory）替换名单**，是底包自己能识别的设备集合。15 Pro（`haotian`）本来就不在该集合里，硬塞进去只会让设备配置解析失败。 |
| `lsp/assets/content/filters.json`、`lut-presets.json` | 若干含 "Ultra" 的条目 | 滤镜/LUT 的**名字**（如「柯达 Ultramax 400」），与机型无关。 |

### C. 死代码：**改不改都不生效**，本次一律不动

| 位置 | 判定依据（可复现） |
| --- | --- |
| `lsp/assets/profiles/aurora.json`（14 Ultra 光学描述） | 唯一读者是 `ProfileRepository.load()`；全 LSP grep `ProfileRepository` **只命中它自己的文件**，没有任何调用点。这份"14 Ultra 四摄/可变光圈"描述在 1.3.0 里是**惰性资产**。 |
| `CameraV51Bridge.hookDeviceFactory()`（`CameraV51Bridge.smali:2557`）及其内部类 `CameraV51Bridge$69`（`...$69.smali:54` 里 `findClass("com.mi.device.Aurora")`） | ① 全 LSP grep `hookDeviceFactory` **只命中定义处和 `$69` 的 `EnclosingMethod` 注解**，没有调用点；② 它要 hook 的 `G7.d` 类在底包解包树里**根本不存在**（`work/camera-base/smali/G7/` 下只有 `a.smali`，其余 dex 目录无 `G7`），`com.mi.device.Aurora` 也不在底包 dex 里（`rg -a "com/mi/device/Aurora" work/camera/build/apk` 无命中，只有 `com/mi/device/ddfConfig`）。 |

> 结论：网上"上游把机型强改成 14 Ultra 所以 15 Pro 会有问题"这类担心在这两处**不成立**——它们是 1.3.0 里没接上的代码。

### D. 只是"设备名表"，与本机身份无关，保留

| 位置 | 内容 | 说明 |
| --- | --- | --- |
| `lsp/smali_classes2/.../ClassicStyleCatalog.smali:6-57` | `MODEL_IDS = {m9, passthrough, neutral, 12su, fuxi, 14u, 17u, blackwhite}` / `MODEL_LABELS` 含「小米 14 Ultra」 | 这是**「徕卡经典色彩风格」可选机型表**（借用各机型的色彩调校），`DEFAULT_MODEL = "17u"`。`14u` 是一项**功能选项**，不是本机身份。删了会少一个可用的色彩风格。 |
| `lsp/smali_classes3/.../colordev/EntryPoint.smali:150-175` | `DISPLAY_IDS` / `DISPLAY_LABELS` 里的 `14u` +「小米 14 Ultra」 | 同上，色彩风格展示名。 |
| `lsp/smali_classes2/.../DevicePresetStore.smali:23` | `"14 Ultra Ti"` | 水印机型预设选项之一（"14 Ultra 钛金属版"），保留。 |
| `lsp/smali_classes2/.../DeviceNameRouting.smali:220-240` | `cleanPreset()` 里对 `"14 Ultra"` 的特判 | 只是保留大小写（`14ultra` → `14 Ultra`）的规范化分支，对 15 Pro 无副作用。 |
| `camera/patch/smali_classes3/Je/c.smali:5364`、`camera/patch/smali_classes10/is.1/c.smali:292` | 机型代号表里的 `"aurora"` | **底包原生就有**（在 `work/camera-base/` 同名文件里同样存在 1 处），不是 Phoenix 加的，属于底包支持的机型枚举。 |

### E. 上一轮已修好的、真正的 15 Pro 结构性问题（本轮无需重复处理）

| 问题 | 15 Pro 上的表现 | 处理 |
| --- | --- | --- |
| ODM 挂载 | 15 Pro **没有 `/system/odm`**（`/odm` 是独立分区），Magisk 的 magic mount 找不到挂载目标 | `01_源码/tools_local/fix_magisk_odm_merge.py`：三种 Root 统一走 `post-fs-data.sh` 挂载 |
| 挂载方式 | 上游的逐文件 bind mount 在 15 Pro 上**不存活**（`/odm` 下 69+108 个文件全变 0 字节，把手机原有的 58 个滤镜都遮住了） | 改「先拷设备目录、再覆盖模块载荷」的真复制 + **目录级** bind，重刷后字节级验收：videofilter 69/69、watermark 108/108 非零 |
| 已确认**没有**风险 | 模块 ODM 载荷里 **不含任何 `.so`**（只有 PNG/webp：videofilter 69 个 + watermark 108 个），不会覆盖 15 Pro 的原生相机库 | 本轮再次确认（`Get-ChildItem module/system -Recurse -Include *.so` 无命中） |

### F. 与 15 Pro 硬件结构不一致、但**当前不生效**的配置

`lsp/assets/profiles/aurora.json` 描述的是 14 Ultra 的光学：

| 字段 | aurora.json（14 Ultra） | 15 Pro 实际 | 若生效会怎样 |
| --- | --- | --- | --- |
| `lensCount` | 4 | 3 | 变焦 UI 多一档 |
| 镜头 | 12 / 23 / 75 / 120 mm | 14 / 23 / 120 mm | **3.2×（75 mm）档位没有对应物理镜头** |
| `aperture.variableRole` | `MAIN`，1.63–4.0 可变 | 主摄固定 f/1.44 | 光圈面板会出现但实际不可调 |
| `minimumZoom` | 0.5 | 0.5 | 一致 |

**因为该文件是死代码（见 C 节），这四项当前不会产生任何实际影响。** 本次按"改动最小"原则不动它；若将来上游把它接上（例如用于覆写变焦档位），**必须先按第 2 节的实测值重做一份 15 Pro 描述**，否则会出现点不动的 3.2× 档和无效光圈开关。

---

## 4. 验证记录

### 4.1 构建

```powershell
Set-Location D:\GPT\_phoenix_build
$env:PYTHONUTF8='1'
& "C:\Users\hyq-18T\AppData\Local\Programs\Python\Python312\python.exe" tools\build_phoenix.py `
  --camera-apk "D:\GPT\_phoenix_build\_input\camera.apk" `
  --android-sdk "D:\GPT\_phoenix_build\_android-sdk" `
  --apktool "D:\GPT\_phoenix_build\tools\vendor\apktool_2.12.1.jar"
```

退出码 0；日志见 `03_输出/build-15pro.log`。

### 4.2 逐条目回归比对（v1 `04_交付/Phoenix-1.3.0/` → v2 `04_交付/Phoenix-1.3.0-15Pro/`）

| 产物 | 条目数 v1 / v2 | 仅 v1 有 | 仅 v2 有 | 内容（CRC32）不同 |
| --- | --- | --- | --- | --- |
| `Phoenix_Camera_Phoenix-1.3.0.apk` | 6792 / 6792 | 0 | 0 | **0**（重建是等价复现） |
| `Phoenix_LSP_Phoenix-1.3.0.apk` | 206 / 206 | 0 | 0 | **37**，全部是 `assets/prometheus/watermark-suffix/111/mivi_{1..37}.json`（10,049 → 10,047 B）；`classes2.dex` 长度不变但 CRC32 由 `0x07B19164` → `0x75467D1E` |

`classes2.dex` 长度不变的原因：字符串池里 `14 Ultra` 这条**仍然需要**（`DeviceNameRouting` 还在用），新增的是 `15 Pro`；dexlib2 重排后总长恰好落回同一 4 字节对齐边界。

### 4.3 产物内回读（把新 APK 重新解包后 grep，确认改动真的进了成品）

- `WatermarkAssetRouter.smali:64` → `const-string v1, "15 Pro"` ✅
- `DevicePresetStore.smali` → `.locals 8` + `filled-new-array/range {v0 .. v6}` + 两个数组尾部 `"15 Pro"` ✅
- `assets/prometheus/watermark-suffix/111/mivi_1.json:159` → `"text": " 15 Pro"` ✅
- LSP 内 ` 14 Ultra`（带前导空格的水印模板文本）→ **0 命中** ✅
- LSP 内剩余 `14 Ultra` 共 3 条字符串，全部是第 3 节 D 类里的合法项 ✅

### 4.4 签名与对齐

| 检查 | 结果 |
| --- | --- |
| `apksigner verify --print-certs`（LSP） | 通过，`CN=Phoenix Development`，SHA-256 `7d0371b0…6376`（与上一版同一把 `work/keys/development.keystore`，可直接覆盖安装） |
| `zipalign -c -p -v 4`（LSP） | `Verification succesful`（exit 0） |
| `zipalign -c -p -v 4`（Camera） | exit 0（6794 条目） |
| 相机 APK 签名 | 仍为「官方 OEM Signing Block 搬运」，`apksigner verify` 报 `DOES NOT VERIFY`，**安装依赖核心破解**（与上一版一致） |

### 4.5 整合包内容

`Phoenix_Phoenix-1.3.0_AllInOne.zip` = `module/` 脚本 + `watermark_cache/` + `watermark_suffix/` + `system/odm/` + 两个 APK。
包内 `module.prop`（269 B）实测为：

```
id=phoenix_camera_15pro
name=Phoenix Camera - Xiaomi 15 Pro
version=Phoenix-1.3.0
versionCode=2010300
author=Prometheus Port
description=Prometheus Cam 根模块：相机与 LSP 协同，内置滤镜与水印开机即用。本包按 Xiaomi 15 Pro（haotian）适配。
```

---

## 5. 实机刷入与验收（2026-09-28 21:13 完成）

本版**已实机刷入并通过运行期验收**，完整记录见 `06_测试/装机-20260928-15Pro版本/实机刷入验收报告.md`。

| 验收点 | 结果 |
| --- | --- |
| 模块落盘 | `/data/adb/modules/phoenix_camera_15pro/`，`module.prop` 全部正确 |
| 管理器显示模块名 | **Phoenix Camera - Xiaomi 15 Pro**（截图 `05-模块列表-Phoenix-Camera-15Pro.png`），已无「14 Ultra」 |
| 相机 APK 哈希 | `1ff69faf...dbe72a`，与交付件逐字节一致 |
| LSP APK 哈希 | `55fa4c26...9bc57`，与交付件逐字节一致 |
| LSP 注入 | 相机进程内 ABI 探测 `phoenix-camera-os4`，拍照/滤镜/LUT/徕卡水印等 hook 全部 installed |
| ODM 挂载 | `mountinfo` 命中 2 条（videofilter + watermark），`Phoenix ODM assets mounted successfully` |
| 水印机型串 | 相机 `files/` 下含 `15 Pro` 文件 62 个，含 `14 Ultra` 0 个 |
| 相机运行 | `pidof`=26668，`topResumedActivity=com.android.camera/.Camera`，`logcat -b crash` 为空 |

### 5.1 未完成 / 建议

1. **实拍水印终检 + 机型选择列表 UI 确认**：拍一张带徕卡水印的照片，确认印出机型为 `Xiaomi 15 Pro`——因 `postProcessMivi` 仅在名字以 ` by Leica` 结尾时替换模板节点，本机默认名 `15 Pro` 不走该分支，实际印出的是**模板静态文本**（37 个模板已改、设备侧 62 个文件已落地，预期正确，建议实拍确认）；相机内「机型选择」列表第 7 项 `15 Pro` 目前仅静态确认（`.locals 8` + 数组含该串），UI 未截图。
2. **相册编辑器版本**：设备现为 `2.4.0.5.2`，上游要求 `2.4.0.4.3`，仍按你的要求**暂缓降级**。8 个 LSP 桥接目标类已实测缺 5 个，滤镜投射链路视为失效（见 `05_文档/相册编辑器版本绑定实测-2.4.0.5.2.md`）。
3. **15 Pro 未登记在底包机型表中**：底包（17 Ultra OS4 相机）的机型枚举里没有 `haotian`，长期行为（OTA 兼容、机型分支功能）未评估。
4. **底包不可更换**：仍必须 `6.6.000510.0`（SHA-256 `6bf98a86…47b662`）。15 Pro 自带的 `6.7.000180.0` 补丁命中率仅 57.8%、混淆类 0/37，直接换底包不可行（见 `05_文档/底包版本结论-为什么必须6.6.000510.0.md`）。
5. **改动前的原件**已备份在 `01_源码/修改前原件备份-20260928/`（`module.prop`、`WatermarkAssetRouter.smali`、`DevicePresetStore.smali`、37 个 `mivi_*.json`），可随时回退。