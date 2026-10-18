# NaturalTuning v1.4.0 与小米 15 Pro 适配说明

日期：2026-10-18
上游：`Prometheus-Camera` `natural-tuning/v1.4.0`
目标机：小米 15 Pro `haotian` / `2410DPN6CC` / OS3.0.309.0.WOBCNXM

## 1. 上游 v1.4.0 做了什么

- 机型范围：仅小米 14 Ultra（`aurora`）。
- 形态：KernelSU/Magisk 模块 + LSPosed 设置开关。
- 模块把四颗后摄的 `com.qti.tuned.aurora_*.bin` 单文件 bind mount 成「原色」版本。
- 改动节点：Gamma 1.5、CC 1.4 去增艳分支、LTM 2.0.2 静态增量、CV 1.2 / 2D LUT 1.1 增量，以及多帧降噪后处理、超分、HDR、RAW HDR、人像、夜景、AIUR、闪光等深层节点。
- v1.4.0 相对旧版修复了 14U DRC 参数差异造成的动态范围压缩，暗部更深、高光更亮。

关键点：上游不是给生动叠一张 LUT，而是在 CamX tuning 里走进 18PM 的 `Feature0=Natural(12)` 分支，替换对应节点数据。

## 2. 为什么不能把 14U 的包直接套到 15 Pro

1. 15 Pro 的 tuned bin 是带 ASCII name table 的 V6 格式，没有 18PM V7.1.1 的内嵌 schema；无法像上游那样按字段名整树解码。
2. 15 Pro 的模块版本不同：主摄是 `gamma152_ipe_v2` / `cc14_ipe_v2` / `ltm203_ipe_v2`，14U 是 `gamma15` / `cc14` / `ltm202`，叶结构与触发轴不一致。
3. 15 Pro 主摄有两颗模组供应商的 bin：`semco_ovx9100_wide_ii` 与 `ofilm_ovx9100_wide_i`。本版曲线取自 semco wide_ii。
4. 上游模块安装时会校验四颗 14U 原厂 bin 的 SHA-256，15 Pro 上必然拒绝安装。
5. 上游 v1.4.0 的 DRC 修复是 14U 专属参数，15 Pro 没有对应节点，不能直接吃。

结论：15 Pro 不能照搬 14U payload；本版采用「只对徕卡生动请求追加原色 LUT」的方案，风险最低、可随时停用。

## 3. 本版技术实现

### 3.1 Gamma 来源

从 15 Pro 主摄 bin 提取真实生动 Gamma：

```text
com.qti.tuned.haotian_semco_ovx9100_wide_ii.bin
region: gamma152_ipe_v2
sid:    57633
points: 257
```

未使用近似曲线，直接从 tuned bin 的 257 个 float32 读取。

### 3.2 18PM 原色曲线

来自上游 v1.4.0 附件 `natural_curve_18pm.json`，257 点，`/1023` 归一化。

### 3.3 LUT 生成

```text
x   = 15Pro_vivid_inverse(input)
out = 18PM_natural(x)
out = luma + (out - luma) * 0.97
```

- 64³，8×8 atlas，512×512 RGB PNG。
- 图集方向：`x=R, y=G, tile=B`。
- 之前版本存在 R/G 轴转置错误，已修正并验证：
  - `(63,0)` = 红
  - `(0,63)` = 绿
  - `(63,63)` = 黄
  - `(448,448)` = 蓝

### 3.4 Hook 逻辑

`NaturalHook` 最终实现为两条生效路径 + 一条 LUT 发布链路：

1. hook `CaptureRequest.Builder.set`，记录 `com.xiaomi.sessionparams.stylizationType`，只标记 `vivid=true` 的 builder，并记录 `com.xiaomi.mivi2.renderType`。
2. **默认生动兜底（H1）**：hook `j9.D0.H1(int, CaptureRequest.Builder)`。拍照模块、`vivid=true` 且请求里还没有 MIVI payload 时，补一个合成 payload：
   - `renderType=1`（普通滤镜 + LUT，不是 CV 的 32）
   - `generalFilterId=3`（Natural）
   - `filterScript=@CubeLutEffect;cube_strength=1.0;lut_type=0;@`
   - `lutNames=["lut_cvstyle_natural"]`
3. **手动 Natural 滤镜改写（t0）**：hook `j9.m0.t0(CaptureRequest.Builder, byte[])`。仅当 `module=0xa3`（拍照）、`vivid=true`、payload 的 `generalFilterId=3` 时，把原厂 `lut_normal_natural` 换成 `lut_cvstyle_natural`，删除多余 `CvEffect`，并保持 `renderType=1`。Vivid / Chrome / Standard 滤镜不改。
4. hook `com.xiaomi.camera.mivi.filter.a.run`，拦截本 LUT 的发布，把 APK 内的明文 PNG 交给 `MIVILutSaver.writeLutToDir`。
5. 首次命中时打印 `module`、`vivid`、payload 摘要，便于真机确认。

### 3.5 与上游的差距

| 项目 | 上游 14U v1.4.0 | 本版 15 Pro |
| --- | --- | --- |
| Gamma | tuned bin 节点替换 | 3D LUT 近似 |
| CC 去增艳 | tuned bin 分支替换 | 仅 0.97 轻降饱和 |
| LTM 静态增量 | tuned bin 节点替换 | 未移植 |
| CV / 2D LUT 增量 | tuned bin 节点替换 | 未移植 |
| 深层节点（HDR/夜景/人像等） | tuned bin 节点替换 | 未移植 |
| DRC v1.4.0 修复 | 14U 专属 | 不适用 |
| 生效范围 | 徕卡生动拍照 | 徕卡生动普通拍照 |

因此本版应描述为「18PM 原色 Gamma/色彩近似」，不能描述为「完整 v1.4.0 移植」。

### 3.6 Hook 落点静态核验（本次新增）

对相机 10 个 dex 做了 dexdump 级核对，五个落点均真实存在：

| 落点 | 证据 |
| --- | --- |
| `j9.D0.H1(int, CaptureRequest.Builder)` | 拍照请求构建入口；用于默认生动、无 MIVI payload 时补 render tag |
| `j9.m0.t0(CaptureRequest.Builder, byte[])` | 方法存在，内部调用 `ga.E0.f(builder, ga.A0.d, payload)` 写入 MIVI payload |
| `com.xiaomi.camera.mivi.filter.a.run()` | 实现为 `MIVILutSaver.b(field.b, field.c, field.d, field.a)`；字段类型 `a=Z, b/c/d=String`，与 Hook 读取一致 |
| `MIVILutSaver.writeLutToDir(String,String,byte[])` | 存在，返回 `Z`；内部按持久化目录写文件 |
| `com.android.camera.module.Y.a` | `public static int`，运行时保存当前 module id；`0xa3 = 163` 为拍照模块 |

JSON 字段也已核对：

- `MIVIRenderTag.initParams()` 写入 `version`、`renderType`、`lutPath`、`filterScript`、`cvFilterCandyParams`、`cvFilterLutName`、`lutNames`。
- `cvFilterCandyParams` / `cvFilterLutName` 只在 payload `version < 3.002` 时写入；`filterScript` 与 `lutNames` 不受此限制，所以 Hook 同时改 `filterScript` 和 `lutNames` 是必要的双保险。
- CV 滤镜位确认为 `32`：`getCvFilterCandyParams` 里是 `and-int/lit8 #int 32`。本版**不用** CV 位，`renderType` 保持 `1`（普通滤镜 + LUT）。
- 内置 Natural 滤镜原厂 payload 实测为 `generalFilterId=3`、`renderType=1`、`lutNames=["lut_normal_natural"]`；本版只改写这一类。
- 纯 LUT 的 `filterScript` 使用：

```text
@CubeLutEffect;cube_strength=1.0;lut_type=0;@
```

结论：静态层面 Hook 没有落空；两条路径均已在真机命中。

## 4. 已完成与实测

已完成：

- 上游 v1.4.0 源码、README、CHANGELOG、LTM/CV/组合设计文档解包与核对。
- 15 Pro `gamma152_ipe_v2` 真实曲线提取。
- LUT 重建、atlas 方向修正、预览图生成。
- LSP APK 重建、签名、asset 回读校验。
- 两条生效路径落地：默认生动 `H1` 兜底、手动 Natural 滤镜 `t0` 改写。
- 临时关闭开关 `/data/data/com.android.camera/files/natural15pro.off`。

真机实测：

- LSPosed 正常注入，日志出现 `installed; photo-module vivid requests only`。
- `LUT asset loaded bytes=38773`。
- `writeLutToDir path=/data/vendor/camera/ bytes=38773 result=true`。
- 默认生动按快门命中 `vivid fallback injected`。
- 手动 Natural 滤镜命中 `MIVI payload rewritten to lut_cvstyle_natural`。
- 同一场景 A/B：成片与离线 LUT 平均绝对误差 R/G/B `1.09 / 0.76 / 0.97` 级；与原图 `21.98 / 18.64 / 15.35` 级。
- 「徕卡经典」实拍回归，LSPosed 日志无注入，经典风格仍生效。
- 当前设备已切回「徕卡生动」，临时关闭标志已删除。

仍未做：

- 设备实际使用 semco wide_ii 还是 ofilm wide_i 主摄 bin 未最终确认；当前曲线取自 semco wide_ii。
- LTM / DRC / CC / CV 节点移植未做。

## 5. 当前构建

```text
APK      PhoenixAddon-NaturalTuning-15Pro-V1.4.0-槐蔭區2改.apk
版本     1.4.0-15Pro-4（versionCode 4）
大小     98,872 字节
SHA-256  2C6D246F3A2556A0180A8E69CA89F49BA6D70DBD0DC1C852823286E224E7A808
LUT      CEBA97B252E7FE81D435A02F94AE906C1FC576C2A3BC2BF4B5FA88F8A725F320
```

## 6. 后续可选增强

按收益排序：

1. 用更多场景 A/B 校准饱和度与暗部，必要时把 0.97 调整为按镜头区分。
2. 确认主摄实际使用的 bin；若为 ofilm wide_i，重新提取该 bin 的 `gamma152_ipe_v2` 曲线并重生成 LUT。
3. 若要更接近上游，可继续解码 15 Pro V6 bin 的模式树/触发树，做 CC14 与 LTM203 的定向节点替换；工作量和风险都明显高于当前 LUT 方案。
