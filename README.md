# Phoenix Camera · 小米 15 Pro 二改（槐蔭區2改）

把上游 [Prometheus-Camera / Phoenix](https://github.com/benbaobaoshigemi/Prometheus-Camera) 的 **Phoenix 1.3.0**
移植到 **小米 15 Pro（代号 `haotian` / `2410DPN6CC`）**，并在此基础上修复实机遇到的若干问题。

> **二改署名：槐蔭區2改**　｜　上游：`benbaobaoshigemi/Prometheus-Camera`（GPL-3.0-only）

## 一、适配对象与前置条件

| 项 | 要求 |
| --- | --- |
| 机型 | 小米 15 Pro（`haotian`），澎湃 OS |
| 相机底包 | 官方相机 **6.6.000510.0**（SHA-256 `6bf98a86a8e6090b86cf41cb178ef44512171503d3edb685e2564954af47b662`）——上游仅支持该版本 |
| 必需环境 | ROOT + LSPosed + 核心破解，三者缺一不可 |
| 相册编辑器 | `com.miui.mediaeditor` 建议 `2.4.0.4.3`（本机实测 `2.4.0.5.2` 上滤镜投射链路失效） |

## 二、成品（`成品/`）

| 文件 | 大小 (B) | 说明 |
| --- | --- | --- |
| `Phoenix_Camera_Phoenix-1.3.0.apk` | 222,392,852 | 相机本体（versionCode `760010300`），覆盖安装 |
| `Phoenix_LSP_Phoenix-1.3.0.apk` | 13,037,169 | LSPosed 模块（versionCode `2010300`） |
| `Phoenix_Phoenix-1.3.0_AllInOne.zip` | 212,110,975 | Magisk 模块（内含上面两个 APK + ODM 资产 + 模块脚本） |
| `PhoenixAddon-LegendM3-V2.0.0-15Pro-Module-r17-final.zip` | 15,569,626 | 「徕卡一瞬 M3」Magisk 模块（附加件） |
| `PhoenixAddon-LegendM3-V1.0.0-LSP.apk` | 61,984 | 「徕卡一瞬 M3」LSPosed 模块（附加件） |

完整 SHA-256 见 `成品/SHA256校验清单.md`。大文件以 **Git LFS** 存放。

## 三、安装顺序

1. Magisk 刷 `Phoenix_Phoenix-1.3.0_AllInOne.zip` → 重启。
2. 安装 `Phoenix_Camera_Phoenix-1.3.0.apk`（覆盖安装，一般无需清数据）。
3. LSPosed 安装 `Phoenix_LSP_Phoenix-1.3.0.apk`，作用域勾 `com.android.camera` / `com.miui.mediaeditor` / `system`，重启。
4. 需要「徕卡一瞬」时，再刷 `PhoenixAddon-LegendM3-V2.0.0-15Pro-Module-r17-final.zip` 并安装 `PhoenixAddon-LegendM3-V1.0.0-LSP.apk`。

## 四、本二改相对上游做了什么

| 项 | 说明 | 落点 |
| --- | --- | --- |
| 机型标识 15 Pro 化 | 水印 / 机型 / 模块名由 14 Ultra 改为 15 Pro | `camera/patch`、`module/module.prop` |
| `/odm` 挂载永久修复 | 改为真复制 + 目录级 bind，消除 0 字节占位 | `module/` |
| 夜景 · 徕卡经典出绿 | 保留经典风格前提下修正常生效 | `camera/patch` |
| 超清 / 夜景 EV 面板空白 | EV 刻度恢复可调 | `lsp/` |
| 人像模式 EV 面板 | 扩展 DEVCFG 白名单 + 插入 EV 入口 | `lsp/`（`CameraV51Bridge$71` / `$72`） |
| 实况运镜 · 红毯卡死 | 15 Pro HAL 缺 `enableMasterLivePhoto`，摘除红毯预设 | `camera/patch/smali/v2.1/d0.1.smali` |
| 实况运镜内嵌视频 EIS 回归 | 恢复全幅 | `lsp/` |
| 实况运镜片尾回程 | 回程不再闪回最小倍率 | `lsp/` |
| 超清实况子档 + 广角 | 档位补齐 `1.0 / 1.2 / 1.5 / 2.0 / 5.0 / 10.0 / 20` | `camera/patch` |
| 莱卡一瞬 M3 档位子档 | 机型子档位表补 `0x100` | `camera/patch` |
| 自由运镜跨 5x 物理切镜头 | 去程区间 `4.2 → 8.4` 改为 `5.0 → 8.4` | `lsp/`（`PhoenixMasterLiveTailBridge$7`） |

## 五、源码结构

```
camera/patch/    相机 APK 的外挂补丁（1131 个文件，含 patch.json）
lsp/             LSPosed 模块源码（smali + AndroidManifest.xml + assets）
module/          Magisk 模块（module.prop / customize.sh / 资产）
tools/           构建脚本（build_phoenix.py 等）
addons/          上游附加件（LegendM3 / AUTHVignette）
文档/            适配与修复报告
成品/            预编译产物
```

## 六、构建

需要 Python 3.11+、JDK 17+、Android SDK Build-Tools 35.0.0、**apktool 2.12.1**（自行下载放入 `tools/vendor/`）、
以及官方相机底包 6.6.000510.0。

```bash
python tools/build_phoenix.py --mode all \
  --camera-apk /path/to/6.6.000510.0.apk \
  --android-sdk /path/to/android-sdk \
  --apktool tools/vendor/apktool_2.12.1.jar
```

注意：**构建路径必须是纯 ASCII**（apktool 内置 aapt2 无法处理中文路径）。

## 七、署名

本次为**二改**，署名 **槐蔭區2改**，已写入：

- `module/module.prop`：`name=Phoenix Camera - Xiaomi 15 Pro（槐蔭區2改）`、`author=Prometheus Port / 槐蔭區2改`
- `module/customize.sh`：刷入横幅追加 `二改：槐蔭區2改`
- `lsp/AndroidManifest.xml`：`android:label="Prometheus Camera Bridge · 槐蔭區2改"`，`xposeddescription` 追加适配与署名

## 八、免责声明

仅供个人学习与自用。刷机有风险，请自行备份数据并确认可回退到原厂相机。
上游授权 **GPL-3.0-only**；第三方资产（滤镜 / 水印 / 字体等）版权归各自权利人，详见 `third-party.json`。

## 九、已知未完成

- ~~主角运镜片尾 `t≈1.73s` 有一次缩放台阶~~ → **2026-10-09 复测判定不成立**（VFR→CFR 重采样 + 动画起点边界帧造成的假象）；真实现象只有一处 0.324 s 帧空洞，落在静止预录段，观感不可辨。见 `文档/实况运镜台阶-复测与根因-20261009.md`。
- 「徕卡一瞬」入口：点 1x/10x 时档位标签不切成 35mm/480mm；第三方「装了三件套看不到 M3 入口」待干净重装复核。
- 红毯运镜入口：HAL 缺 vendor tag `enableMasterLivePhoto`（硬缺，当前策略是摘除预设）。
- 17U ↔ 15 Pro 字段映射（`asf352` / `ltm203`）未收敛，Legend M3 的 DRC / 整链 19 钩子未落地。