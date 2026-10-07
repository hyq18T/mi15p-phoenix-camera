# 构建记录：小米 15 Pro 用 Phoenix 1.3.0

构建日期：2026-09-28
状态：**构建成功、打包层校验通过；未做真机验证**

## 1. 构建输入

| 项 | 值 |
| --- | --- |
| 上游源码 | Phoenix 1.3.0（`Phoenix` 分支） |
| 底包 | 官方相机 `6.6.000510.0`，SHA-256 `6bf98a86...f47b662` |
| 底包路径 | `02_数据/官方相机-6.6.000510.0-底包.apk`、沙箱 `_input/camera.apk` |

## 2. 构建环境

| 组件 | 版本 / 路径 |
| --- | --- |
| Python | 3.12.10（`C:\Users\hyq-18T\AppData\Local\Programs\Python\Python312\python.exe`） |
| JDK | 21（`java` / `keytool` 可用） |
| Apktool | 2.12.1（`_phoenix_build/tools/vendor/apktool_2.12.1.jar`） |
| Android SDK Build-Tools | 34.0.0（目录名为 `35.0.0`，实际 `Pkg.Revision=34.0.0`，位于 `_phoenix_build/_android-sdk`） |
| 构建沙箱 | `D:\GPT\_phoenix_build` |

**沙箱为什么在项目目录外**：apktool 内置 aapt2 无法处理含非 ASCII 字符的路径，而项目目录名含中文。因此解码、编译、对齐全部在纯 ASCII 路径 `D:\GPT\_phoenix_build` 下进行，产物再收回本项目目录。

## 3. 构建命令

```powershell
$b="D:\GPT\_phoenix_build"
Set-Location $b
$env:PYTHONUTF8='1'     # 必需：build_module() 用 text=True 读 aapt 输出，GBK 会解码失败
& "C:\Users\hyq-18T\AppData\Local\Programs\Python\Python312\python.exe" "tools\build_phoenix.py" `
  --camera-apk "$b\_input\camera.apk" `
  --android-sdk "$b\_android-sdk" `
  --apktool "$b\tools\vendor\apktool_2.12.1.jar"
```

三阶段输出：

| 阶段 | 内容 | 结果 |
| --- | --- | --- |
| [1/3] Camera | 解码底包 → 套用 410 个补丁 → aapt2 编译 → zipalign → 注入 OEM Signing Block | 222,392,852 B |
| [2/3] LSP | 编译 smali 源码 → zipalign → apksigner 签名并 verify | 13,028,977 B |
| [3/3] All-in-One | 打包模块脚本、`system/odm/etc/camera/videofilter` LUT、水印缓存与两个 APK | 212,107,979 B / 1357 条目 |

## 4. 打通构建踩到的四个坑

### 坑 1：底包含 `$` 前缀资源名，aapt2 拒绝

官方底包由 AAPT1 构建，含 132 个 `$xxx__N` 形式的资源名（animated-vector-drawable 内部件），aapt2 报 `invalid entry name`。

修复：`01_源码/tools_local/fix_avd_resource_names.py`，改名并同步改写 49 个 XML 里的引用。资源 ID 由 `res/values/public.xml` 钉住，编号不变。

### 坑 2：patch 的 public.xml 覆盖 base，同样含 `$` 名

修复：`01_源码/tools_local/fix_patch_public_avd.py`，对补丁树的 `res/values/public.xml` 做同样处理。

### 坑 3：Build-Tools 35 无法获取，r34 的 zipalign 不支持 `-P`

上游要求 Build-Tools 35.0.0 并使用 `zipalign -P 16`（16 KiB 页对齐）。实测 Build-Tools 35 全网找不到 Windows 版；r34 的 `zipalign` 只有 `-p`（4 KiB），没有 `-P <kib>`。

修复：自写 `01_源码/tools_local/zipalign16.py`，纯 Python 实现 `-P` 语义（对齐信息写进 0xD935 extra 字段）。构建脚本 `assemble()` 改为调用它。

### 坑 4（严重）：zipalign16.py 首版把 53 个条目写成 0 字节

**症状**：LSP 阶段 `apksigner sign` 报 `malformed binary resource: AndroidManifest.xml`，`No XML chunk in file`。

**根因**：apktool 用 Java `ZipOutputStream` 写包，被流式写入的条目会带 data descriptor（通用位标记 0x08），此时**本地文件头里的 CRC / 压缩后大小 / 原始大小全是 0**，真实值只写在中央目录。首版脚本从本地文件头读这些字段，于是写出 0 字节条目并清掉 0x08 标记，产出静默损坏的 APK。

实测受影响：LSP 包 203 个条目中 **53 个被写成 0 字节**（含 `AndroidManifest.xml`、`assets/content/filters.json` 等）。Camera 包走同样的对齐流程，因此同批产物也是坏的——这是必须重建的原因。

**修复**：改为从中央目录读取 `CRC / compress_size / file_size / flag_bits / extract_version`，本地头只用于取 `header_offset` 与原始 extra 字段；并为每个条目加了长度与对齐断言。

## 5. 产物校验（打包层）

| 校验项 | 结果 |
| --- | --- |
| `zipalign -c -v 4`（Build-Tools 34 交叉校验） | `Verification succesful` |
| Camera versionCode / versionName | `760010300` / `Phoenix-1.3.0` |
| Camera package / sdk | `com.android.camera`，minSdk 29，targetSdk 36 |
| LSP versionCode / versionName | `2010300` / `Phoenix-1.3.0`，`com.prometheus.camera.rev` |
| LSP `apksigner verify` | 通过，签名者 `CN=Phoenix Development` |
| 条目数 | 底包 6199 → 产物 6792（+593 为 Phoenix 新增资产） |
| 零字节条目 | 0（对齐后逐条比对 CRC 与大小，无损坏） |
| `lib/*.so` | 48 个，全部**未压缩**（与 `extractNativeLibs=false` 一致，可被加载器直接 mmap） |
| 资源表 | 产物 22,387 条；与 510 底包同 ID 的 21,647 条中 **21,514 条名称一致（99.4%）** |
| Phoenix 资产 | `assets/prometheus` 39、`assets/watermarks` 572、`assets/cloudfilter` 6、`assets/sounds` 39、`assets/shading_script` 4、`assets/phoenix`、`assets/prometheus_runtime` 均在 |
| 签名块 | 产物不含 `META-INF/CERT.*`（正常，改动后原 JAR 签名失效），改用注入的官方 OEM APK Signing Block；LSP 用新生成密钥签名 |
| 模块包 | 1357 条目：`module.prop`、`customize.sh`、`post-fs-data.sh`、`service.sh`、`action.sh`、`sepolicy.rule`、各 sync 脚本、`system/odm/etc/camera/videofilter` LUT、`watermark_cache`、`watermark_suffix` 与两个 APK |

注意：`res/` 内部文件名与底包不同（apktool 把混淆名还原成 `res/<type>/<name>.<ext>` 规范名）。这不影响功能——Android 通过 `resources.arsc` 的 ID 与资源名查找，不看文件路径；上游官方发布包同样是 apktool 构建的规范名。

## 6. 未验证与风险

上游 `verification.json` 对 1.3.0 明确标注 `deviceValidation: not performed`，本节写于实机安装之前。**2026-09-28 已完成实机安装、启动与拍照验证**（见 `06_测试/实机验证/实机验证记录.md`），故下述第 1 条已被证伪，第 4 条已部分澄清。仍待评估的风险：

1. 17 Ultra OS4 相机 APK 是否能在 15 Pro（澎湃 OS3.0、6.4/6.7 相机线）上正常启动、拍照、调用 HAL。上游仅在 14 Ultra 上验证过跨机型。
2. 相机 APK 内没有 `haotian` 机型标识（510 与 570 内只有 `diting` / `xuanyuan` / `zircon` 等），15 Pro 属于未登记机型，可能走入兜底逻辑；LSP 侧只有一个设备配置文件 `assets/profiles/aurora.json`。
3. 15 Pro 预装"小米相册-编辑"为 `2.4.0.5.2`，Phoenix 要求 `2.4.0.4.3`，需按上游要求调整，否则相册侧联动功能可能异常。
4. 15 Pro 现有 18 个 Magisk 模块（含 `zygisk_lsposed`、`baa_unlock`、`device_faker`、`device_features_haotian`、`unlimited_thermal`、`piano_zram` 等）与 LSPosed 模块的作用域是否冲突未验证。其中 `device_faker` / `device_features_haotian` 会改机型标识，可能影响相机的机型分支判断。
5. 相机 APK 依赖 `/odm/lib64/libMiPhotoFilter.so` 与包内 `libMiFilterSDK.so`，15 Pro 上前者存在，但版本不同，暗角 Addon 未验证。
6. 本次产物为本机重建，**LSP 的签名密钥是本机新生成的开发密钥**，与上游发布的 LSP 签名不同；若设备上已装上游 LSP，需先卸载再用本包。

## 7. 重建步骤

1. 确认 `D:\GPT\_phoenix_build` 仍在（含解码树缓存、工具、framework）。
2. 按第 3 节命令执行。若想强制重新解码，删除 `_phoenix_build/work/camera-base/.complete`。
3. 产物落在 `_phoenix_build/dist/Phoenix-1.3.0/`，校验通过后复制进 `04_交付/Phoenix-1.3.0/`。
## 8. 本地修复 5：Magisk 分支的 ODM 合并（第一轮，方向正确但不充分）

前四个坑都是"构建期"问题，这一条是**实机运行期**缺陷，由真机验证暴露（详见 `06_测试/实机验证/实机验证记录.md` 第 3 节）。

### 症状

刷入模块并重启后，`/odm` 下 Phoenix 的 ODM 资产不完整：

| 路径 | 设备实际 | 模块内 | 缺失项 |
| --- | --- | --- | --- |
| `/odm/etc/camera/videofilter` | 58 | 69 | 11 个 Leica LUT：`129_Vivid.png`、`130_Natural.png`、`167_CC.png`、`168_NC.png`、`169_LeicaChrome.png`、`170_LeicaClassic.png`、`171_LeicaContemporary.png`、`172_LeicaEternal.png`、`173_LeicaBrass.png`、`174_LeicaTeal.png`、`175_LeicaIModelA.png` |
| `/odm/etc/camera/xiaomi/watermark` | 106 | 108 | `ic_cv_redmi_logo.png`、`ic_cv_redmi_logo_white.png` |

### 根因

`module/post-fs-data.sh` 的 Magisk 分支直接 `exit 0`，把挂载责任交给 Magisk 的 magic mount，其前提是设备存在 `/system/odm`。**15 Pro 上 `/system/odm` 不存在**：`/odm` 是独立分区（`/dev/block/dm-1 on /odm`，erofs）。没有挂载目标，模块内的 `system/odm` 树永远进不了 `/odm`。KernelSU / APatch 分支走显式 bind mount，不受影响。

### 修复（3 处，全部复用上游已有函数）

`module/post-fs-data.sh`：

1. 删掉 Magisk 分支的 `exit 0`，让三种 Root 统一走合并路径：

```sh
case "$ROOT_FAMILY" in
  magisk|ksu|apatch)
    echo "${ROOT_FAMILY}：执行受控 ODM 子树合并"
    ;;
esac
```

2. `MODULE_ODM` 按 Root 家族取路径（`customize.sh` 只对非 Magisk 把 `system/odm` 搬到 `payload/odm`）：

```sh
case "$ROOT_FAMILY" in
  magisk) MODULE_ODM="$MODDIR/system/odm" ;;
  *) MODULE_ODM="$MODDIR/payload/odm" ;;
esac
```

3. 文件头注释同步说明原因（原文写 "Magisk keeps its system tree"）。

另有两处随改动一起纠正的**措辞**，避免安装日志与检查结果自相矛盾：

- `module/customize.sh`：`Magisk：保持 system/odm 布局，跳过 ODM 目录手动合并` → `Magisk：保留 system/odm 载荷，开机时合并进 /odm`
- `module/verify-mount-owner.sh`：Magisk 分支 PASS 文案改为"由 post-fs-data.sh 挂载 ODM 载荷"

### 固化与自检

按项目既有约定，修复写成可重复执行的归档脚本 `01_源码/tools_local/fix_magisk_odm_merge.py`（用法 `python fix_magisk_odm_merge.py <module-dir>`，幂等）。已验证：

- 对原始上游 `module/` 执行：`post-fs-data.sh: applied 4`、`customize.sh: applied 1`、`verify-mount-owner.sh: applied 2`（第 9 节把实现改为真复制后，`post-fs-data.sh` 的 applied 数为 6）
- 再次执行：全部 `applied 0`
- 对原始源码打补丁后，三个文件与沙箱内交付版本的 SHA-256 **完全一致**

注意：`post-fs-data.sh` 全文为 LF 换行，改动时不要引入 CRLF。

### 重建后的哈希变化（已核对，不是内容变化）

改动只落在模块脚本，但重跑 `--mode all` 会重新编译两个 APK；apktool 与 `zipalign16.py` 写入的 ZIP 条目时间戳取当前时刻，于是相机 / LSP 的 SHA-256 会变。逐条目比对（Python `zipfile` 读中央目录）：

| 产物 | 条目数 | 内容差异（CRC32 / 大小 / 压缩方式 / 外部属性） | 时间戳差异 |
| --- | --- | --- | --- |
| Camera APK | 6792 | 0 | 6792 |
| LSP APK | 206 | 0 | 206 |

即**相机与 LSP 与上一版逐条目等价，仅构建时刻不同**；真正变化的是 `AllInOne.zip`（模块脚本）。当前哈希见 `04_交付/Phoenix-1.3.0/SHA256校验清单.md`。

### 实机验证结果（已被第 9 节更正）

> ⚠️ **更正**：本小节当时只数了文件名个数就判定闭环，**结论是错的**。第二轮复查发现 69 与 108 个文件全部是 **0 字节占位文件**。第一轮改动本身必要（Magisk 分支确实必须自己挂载），但不充分。原因与完整证据见第 9 节。

重刷 AllInOne 并重启（未清任何应用数据）后，当时记录：

- `/odm/etc/camera/videofilter` = **69**，`/odm/etc/camera/xiaomi/watermark` = **108**（仅文件名计数）
- `mount` 可见 `dm-46 on /odm/etc/camera/videofilter` 与 `dm-46 on /odm/etc/camera/xiaomi/watermark`
- 模块 `mount.log`：`magisk：执行受控 ODM 子树合并` / `Phoenix ODM assets mounted successfully`，无 `mount_failed`
- `metamodule-check.log`：`PASS`
- 相机正常启动，`logcat -b crash` 无记录；`KEYCODE_CAMERA` 实拍出图成功

## 9. 本地修复 6：ODM 合并由"逐文件 bind"改为"真复制"（第二轮，实机闭环）

上游 `build_merge_tree()` 用 `bind_entry()` 逐文件拼合并树：

```sh
: >"$destination_path"                              # 先造 0 字节占位
"$BB" mount -o bind "$source" "$destination_path"   # 再把模块真文件盖上去
```

第 8 节沿用这套逻辑，方向对，但**验证方法不严**：只数了文件名个数。第二轮复查推翻了"已闭环"的结论。

### 复查证据

| 检查 | 结果 |
| --- | --- |
| `/odm/etc/camera/videofilter` 文件数 / **非零** | 69 / **0** |
| `/odm/etc/camera/xiaomi/watermark` 文件数 / **非零** | 108 / **0** |
| `md5sum .../129_Vivid.png` | `d41d8cd9...`（空文件 md5）；模块内同一文件 43,103 B |
| 挂 `/dev/block/dm-1` 到 `/data/local/tmp/orig_odm` 看原始分区 | videofilter **58 个真实文件**（`102_SummerDay.png` = 208,282 B） |
| `/proc/mounts` 中模块 `.merge` 路径的挂载 | **0** |

即：目录级 rbind 存活，**逐文件 bind 全部没活下来**，`/odm` 下只剩 0 字节占位文件，连手机原有的 58 个视频滤镜也被遮住——比不装模块更糟。

### 修复

`module/post-fs-data.sh`：

1. 删除 `bind_entry()` 与 `build_merge_tree()` 整段；
2. 新增 `stage_merged_tree()`，改为**先拷设备原有目录、再覆盖模块载荷、统一 `chcon`**；
3. 两处调用点 `build_merge_tree ... mount -o rbind` → `stage_merged_tree ... mount -o bind`；
4. 文件头注释说明为什么必须真复制。

```sh
stage_merged_tree() {
  local source_dir="$1" lower_dir="$2" merge_dir="$3"
  rm -rf "$merge_dir"
  mkdir -p "$merge_dir" || fail "create merge directory: $merge_dir"
  cp -a "$lower_dir/." "$merge_dir/" || fail "copy device tree: $lower_dir"
  cp -a "$source_dir/." "$merge_dir/" || fail "copy module tree: $source_dir"
  chcon -R "$MERGE_CONTEXT" "$merge_dir" || fail "label merge directory: $merge_dir"
}
```

代价：`/odm` 的合并树在 `/data` 上占 **43 MB** 真文件，可接受。

### 归档脚本

`01_源码/tools_local/fix_magisk_odm_merge.py` 同步扩展：除原有 3 处替换外，新增 `rewrite_merge_implementation()`，按 `bind_entry() {` … `rm -rf "$MODDIR/.merge"` 切片替换整段实现，并在末尾断言 `build_merge_tree` / `rbind` / `bind_entry` 均已不存在。

| 场景 | 结果 |
| --- | --- |
| 对原始上游 `module/` 执行 | `post-fs-data.sh: applied 6`、`customize.sh: applied 1`、`verify-mount-owner.sh: applied 2` |
| 再次执行（幂等） | 三个文件全部 `applied 0`、`already present` |
| 与沙箱交付版本逐文件比对 | `post-fs-data.sh` / `customize.sh` / `verify-mount-owner.sh` SHA-256 **完全一致** |

### 重建与字节级验收

重建后重刷 AllInOne、重启（未清任何应用数据）：

| 校验项 | 结果 |
| --- | --- |
| videofilter 总 / 非零 / 空 | **69 / 69 / 0** |
| watermark 总 / 非零 / 空 | **108 / 108 / 0** |
| `129_Vivid.png` md5 | `62f64b63387ea9a6fbaedffad279682f`（与模块载荷一致） |
| `/odm` 下 177 个文件 vs 模块载荷 md5 | **0 处差异** |
| 原始分区 164 个文件基线 | 0 丢失；11 个同名文件被模块载荷覆盖（设计行为），其余 md5 不变 |
| `/proc/self/mountinfo` 挂载源 | `/dev/block/dm-46`（`/data`），目录级 bind |
| `metamodule-check.log` | `PASS: Magisk path mounts the ODM payload from post-fs-data.sh; ...` |
| 相机启动 / 实拍 / 崩溃缓冲 | 正常 / `MVIMG_20260928_023401.jpg` 4096×3072 / 空 |
| `AllInOne.zip` 体积 | 212,107,997 → **212,107,940** B（`post-fs-data.sh` 内容变化） |

### 教训

> 数文件个数 ≠ 验证成功。判断挂载内容是否生效必须看**字节数 / md5**；判断 bind mount 是否存活必须看 `/proc/mounts` 或 `/proc/self/mountinfo`。注意 `grep .merge` 会被 f2fs 的 `gc_merge` / `checkpoint_merge` 挂载选项误伤（本机一次误报 101 条），要用模块完整路径匹配。
