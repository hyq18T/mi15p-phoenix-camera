# 三合一合并源码说明

本目录保留合并后的关键产物与重建脚本，方便以后子模块更新时重新合并。

## 文件

| 文件 | 说明 |
| --- | --- |
| `merge_lsp.ps1` | 从三个原始 APK 重新生成三合一 APK |
| `xposed_init.txt` | 合并后的入口清单（17 条） |
| `AndroidManifest.xml` | 合并后的模块清单，已改 label / description / xposedminversion |
| `module.prop.txt` | LSPosed 模块元数据，`minApiVersion=93`、`targetApiVersion=93` |
| `apktool.yml` | 回编译配置，`versionCode=2010400`、`versionName=Phoenix-1.3.0-AllInOne` |

## 重建

```powershell
powershell -ExecutionPolicy Bypass -File .\merge_lsp.ps1 `
  -MainApk    "D:\path\Phoenix_LSP_Phoenix-1.3.0.apk" `
  -M3Apk      "D:\path\PhoenixAddon-LegendM3-V1.0.0-LSP.apk" `
  -NaturalApk "D:\path\PhoenixAddon-NaturalTuning-15Pro.apk"
```

默认输出到 `合并源码/out/`，默认使用：

```text
apktool：D:\GPT\_phoenix_build\tools\vendor\apktool_2.12.1.jar
Build-Tools：D:\GPT\_phoenix_build\_android-sdk\build-tools\35.0.0
Keystore：..\签名\allinone.keystore（alias=phoenixall，密码=android）
```

如路径不同，用参数覆盖 `-ApktoolJar`、`-BuildTools`、`-Keystore`、`-WorkDir`、`-OutDir`。

## 合并规则

1. 以主 LSP 为外壳，保留包名 `com.prometheus.camera.rev`。
2. M3 与 Natural 的 smali 依次放入主 LSP 的空闲 `smali_classesN`（本次为 12、13）。
3. 两者的 `assets` 原样并入主 `assets`。
4. 三个 `assets/xposed_init` 去重合并。
5. `AndroidManifest.xml` 改 label、`xposeddescription`、`xposedminversion=93`。
6. `META-INF/xposed/module.prop` 改 `minApiVersion=93`、`targetApiVersion=93`。
7. 回编译后用 `zipalign` 对齐，再用固定 keystore 签名。

## 注意

- 三个子模块的类名必须无冲突；合并前可用 `dexdump` 或 `baksmali` 比对类清单。
- 合并后不能单独升级子模块，更新任一子模块都要重新跑本脚本。
- 脚本会删除并重建 `-WorkDir` 下的 `main`、`m3`、`nat` 三个目录，不要把它们指向正式源码目录。
