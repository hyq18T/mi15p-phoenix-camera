# LegendM3 V2.0.0 → 小米 15 Pro：ImageParams 0xD8 布局根因与 r17 定稿（2026-10-04）

设备 `dc16f1e0`（haotian / 2410DPN6CC / OS `3.0.309.0.WOBCNXM`），Magisk root，相机 `com.android.camera`（Phoenix-1.3.0）。
产出：`04_交付/LegendM3-V2-15Pro-r17-final-20261004/`
证据：`06_测试/LegendM3-V2-15Pro-r17-20261004/`

## 1. 症状（r5 之后一直卡在这里）

r3/r4/r5 依次解决了入口符号（`miviconnect`）、vtable 槽位（14U 15 槽 → 15 Pro 18 槽）、注册门禁
（AEC/LTM/ASF build-id 不匹配导致的 `connect()` 返回 false）。这三层修完后：

- 插件能被引擎注册、`isEnabled` 能返回 true（`style selected module=256`）；
- 但**成片始终是 1440x1080、40~49 KB 的极暗 JPEG**，即引擎在插件 `process()` 内崩溃后中止管线，
  回退到 HAL 早期 JPEG；`/data/tombstones` 无新增（信号被 Mivi 捕获）。

r6~r15 一路加探针（MiaParams、slot、raw、hex、深拷贝）都没定位到，因为**所有探针读的都是同一份错误布局**。

## 2. 根因：15 Pro 的 ImageParams 是 0xD8 字节，不是 14U 的 0x98

插件拿到的 `ImageParams` 由引擎构造。14U 与 15 Pro 的引擎不是同一版本，结构体长度与字段偏移全变。
按 14U 布局取 `stride/plane_ptrs/native_handle` 时读到的全是垃圾 → `process()` 内 `AHardwareBuffer_createFromHandle`
拿到野指针 → `SIGSEGV`（`fault addr 0xc40`，线程 `AlgoFwkThd0`）→ 管线中止 → 回退早期 JPEG。

修复后的正确布局（`native/mivi14.h`，带 `static_assert` 固化）：

| 偏移 | 字段 | 说明 |
| --- | --- | --- |
| `+0x00` | `format` | HAL pixel format（实机 `35` = `HAL_PIXEL_FORMAT_YCBCR_420_888`） |
| `+0x04` | `width` | 4096 |
| `+0x08` | `height` | 3072 |
| `+0x24` | `stride` | 4096 |
| `+0x28` | `scanline` | 3072 |
| `+0x30` | `metadata` | `MiMetadata*`（由 `shared_ptr` 持有，`+0x38` = 控制块） |
| `+0x60` | `num_planes` | 2 |
| `+0x64` | `fd_slots[3]` | 每 plane 一个 dma-buf fd |
| `+0x70` | `plane_ptrs[3]` | 每 plane 基址 |
| `+0x88` | `native_handle` | 原厂 filter 的 gralloc 路径用 |
|  | `sizeof` = **0xD8** | 引擎每个 buffer 只给一个元素 |

### 2.1 证据链

1. **反汇编 15 Pro 原厂插件**（`02_数据/参考库-15Pro/com.xiaomi.plugin.filter.so`）
   `convertImageParams`（vtable `+0x78`，@`0xe54c`）直接逐字段读：
   `ldr w,[x1]`→fmt、`+4`→w、`+8`→h、`+0x24`→stride、`+0x28`→scanline、`+0x60`→num_planes、
   `+0x70`→plane_ptrs、`+0x64`→fds。
2. **GraphicBuffer 构造点**（@`0xd3a4`/`0xd3ec`）：`ldr x8,[x8,#0x88]` 取 `native_handle`，
   再 `ldr w5,[x8]`/`ldp w3,w4,[x8,#4]`/`ldr w8,[x8,#0x24]` 取 fmt/w/h/stride。
3. **MiMetadata::find 调用点**（@`0xd0e4`/`0xd608`）：`ldr x21,[x9,#0x28]`，其中 `x9 = ImageParams+8`，
   即对象字在 `ImageParams+0x30`；`isEnabled` 侧元数据指针在 `MiaParams+0x18`。
4. **修复后实时 dump**（曾临时打 `PhoenixM3Desc`，已在 r17 删除）：
   `in fmt=35 4096x3072 stride=4096 scanline=3072 planes=2 fd=578,578,578 p0=... p1=... nh=0xb400... md=0xb400...`
   ——字段全部自洽（旧布局下这些值是乱码）。
5. **修复后日志**：`style submitted lux=535.791 zoom=1 format=9 4096x3072` + `style request result=0`
   + `grain process width=4096 height=3072 stride=4096 result=0`，且无 `SIGSEGV`。

### 2.2 附带发现：本插件里 `std::map/std::vector::size()` 不可靠

15 Pro 引擎侧传下来的 `BufferMap`（`map<uint32_t, vector<ImageParams>>`）在本插件 ABI 下
`size()`/`begin()->second.size()` 返回垃圾（实测 `0x35E1...`）。
判空/取元素一律改用 **`vector::data()`**：空容器 `data()` 为 `nullptr`，元素指针可直接使用。
注意 `data()` 返回的是 **MTE 标签指针（`0xb4...`）**，属正常现象，不要再做掩码 sanity 检查。

## 3. 本轮代码改动（相对上游 V1.0.0 源）

`addons/LegendM3/source/native/`

| 文件 | 改动 |
| --- | --- |
| `mivi14.h` | `ImageParams` 重写为 0xD8 布局 + `static_assert` 固化 offset；`kMiaParamsMetadataOffset = 0x18` |
| `m3_style_plugin.cpp` | `processRequest(Request*)` 用 `vector::data()`；`process()` 从 `input.metadata` 取元数据 |
| `m3_grain_plugin.cpp` | `processRequest(Request*)` 用 `vector::data()` |
| `m3_aux.cpp` | `input.object_28` → `input.metadata` |
| `m3_monopan.cpp` | `read32` 偏移同步：`0x48→0x60`、`0x1c→0x24`、`0x20→0x28`、`0x58→0x70`、`0x4c→0x64` |

r14 之前引入的 `m3_sane_ptr` 掩码辅助函数已删除。

## 4. r17 定稿（正式版）

1. **删除全部调试探针**：`M3_TRACE` 宏、`PhoenixM3Slot` / `PhoenixM3Probe` / `PhoenixM3Raw` /
   `PhoenixM3Desc` 及其 `*_budget` 计数器（`m3_style_plugin.cpp`、`m3_grain_plugin.cpp`）。
   保留的是有长期价值的行为日志：`style request result=`、`grain process ...`、`aux publish ...`。
2. 重新编译（NDK r27c，`inputs/platform-15pro` 平台头 + 设备 `libc++_shared.so`）：
   `com.xiaomi.plugin.m3style.so` 19520 B、`com.xiaomi.plugin.m3grain.so` 16920 B。
3. 两种 `connect` → `miviconnect` 就地名改造 + `.gnu.hash` 重建（脚本 `patch_release_r17.py`）。
4. 打包 `PhoenixAddon-LegendM3-V2.0.0-15Pro-Module-r17-final.zip`（15,569,626 B，
   SHA-256 `2ced5a6d42eb1ace9bcec07998dcfb714805d1173be6588727eeeb377ac6beb5`），
   `module.prop`：`version=V2.0.0-15Pro-r17-final`、`name=PhoenixAddon-LegendM3-15Pro`。
5. `magisk --install-module` 刷入 + 重启。

## 5. 实机验证

### 5.1 热替换阶段（已完成）

| 检查项 | 结果 |
| --- | --- |
| `PhoenixM3Desc` 等探针日志 | **10:38 之后 0 行**（残余 43 行全部是 10:32–10:34 的历史 buffer） |
| `style request result` | `0` |
| `aux publish` | `image=IMG_20261004_103945.jpg size=4096x3072 bytes=18874368 result=0` |
| `grain process` | `width=4096 height=3072 stride=4096 result=0` |
| LSP 侧成片 | `M3 JPEG committed input=7088245 output=8621637 aux=1532015` |
| 成片 | `IMG_20261004_103945.jpg`，8,621,637 B，4096x3072，黑白 + 暗角 + 颗粒（M3 预期影调） |
| 崩溃 | 日志 `Fatal signal/SIGSEGV` 计数 = 0 |

### 5.2 冷启动阶段（已完成，2026-10-04 12:13）

| 检查项 | 结果 |
| --- | --- |
| 模块版本 | `V2.0.0-15Pro-r17-final` |
| 挂载 | `mount.log` = `M3 ODM graphs, plugins and assets mounted`；`/odm/lib64/camera/plugins/` 下 19520 / 16920 B |
| `style request result` | `0`（`lux=533.037 zoom=1 format=9 4096x3072`） |
| `aux publish` | `size=4096x3072 bytes=18874368 result=0` |
| `grain process` | `width=4096 height=3072 stride=4096 result=0` |
| 成片 | `IMG_20261004_121322.jpg`，8,595,228 B，4096x3072（LSP 侧 `input=7097880 output=8595228 aux=1495970`） |
| 探针残留 | 0 行 |
| 相机崩溃 | 0（日志里唯一 `Fatal signal` 是 10:42 重启过程中 `init` 的 SIGABRT，与相机无关） |

→ 结论：**模块冷启动后 M3 链路完整生效，r17-final 可交付。**

## 6. 未决与风险

1. **观测到的成片是插件参与的结果**：`style/grain` 均由插件 `process()` 返回 0 并写出 4096x3072 aux，
   LSP 侧 `aux matched` 后才 `M3 JPEG committed`。这与 r5 文档里“插件未参与”的结论不同，属本轮修复后的新状态。
2. 插件仍**没有** 14U 原生的 AEC/LTM/ASF 调校（`connect()` 仍为 fail-soft），观感与 14U 原版存在差距。
3. 实况运镜内嵌视频变焦丢失、超清实况缺 0.5× 广角两项仍开放（与 M3 插件链路无关，见各自文档）。

## 7. 回滚

热替换阶段：重新 `cp` 旧 `.so` 到 `/odm/lib64/camera/plugins/` 并 `setprop ctl.restart vendor.camera-provider`。
模块阶段：刷回 `04_交付/LegendM3-V2-15Pro-r5-abi18-failsoft-20261003/` 内的模块包后重启。