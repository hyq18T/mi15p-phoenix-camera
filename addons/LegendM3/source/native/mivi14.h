#pragma once

// OS4 14U Mivi/PluginWraper ABI views recovered from the device engine and
// the stock 14U filter ELF.  This header is an analysis contract: it contains
// only offsets that are directly evidenced by AArch64 loads/stores.  The
// request views are prefixes and must not be used as complete host objects
// until the remaining fields have been recovered.

#include <cstddef>
#include <cstdint>
#include <type_traits>

namespace m3::mivi14 {

// FilterPlugin::initialize(CreateInfo*, MiaNodeInterface) receives this
// aggregate by value (AArch64 source address in x2).  filter.so:0xc08c copies
// exactly eight qwords from x2 to this+0x08..0x40.
struct MiaNodeInterface {
    std::uintptr_t words[8];
};
static_assert(sizeof(MiaNodeInterface) == 0x40);

// MiaNode::isEnable copies 0x48 bytes before dispatching PluginWraper's
// isEnabled slot (libmialgoengine.so:0x46454).  The payload is opaque here;
// only the copy size is asserted by the engine call site.
struct MiaParamsOpaque {
    std::uint8_t bytes[0x48];
};
static_assert(sizeof(MiaParamsOpaque) == 0x48);

// MiaParams carries the MiMetadata pointer the engine hands down to
// PluginWraper::isEnabled(MiaParams).  On the 15 Pro engine that pointer lives
// at +0x18: stock com.xiaomi.plugin.filter.so:0xd0d4 is `ldr x0, [x1, #0x18]`
// inside its isEnabled slot.  The 14U build read it from +0x00, which on the
// 15 Pro yields a garbage pointer and faults inside MiMetadata::find.
inline constexpr std::size_t kMiaParamsMetadataOffset = 0x18;

// The complete ImageParams object on the 15 Pro engine is 0xD8 bytes.  The
// stock 15 Pro com.xiaomi.plugin.filter.so reads it directly, and its
// convertImageParams (vtable +0x78) pins every scalar: format/width/height at
// +0/+4/+8, stride at +0x24, scanline at +0x28, plane count at +0x60, the fd
// array at +0x64 and the plane pointers at +0x70.  The same plugin builds a
// GraphicBuffer from the native handle at +0x88 and calls MiMetadata::find on
// the shared_ptr object word at +0x30.  The live engine hands the plugin a
// single 0xD8-byte element per buffer.
struct ImageParams {
    std::uint32_t format;              // +0x00
    std::uint32_t width;               // +0x04
    std::uint32_t height;              // +0x08
    std::uint32_t unknown_0c;          // +0x0c
    std::uint32_t unknown_10;          // +0x10
    std::uint32_t unknown_14;          // +0x14
    std::uint32_t unknown_18;          // +0x18
    std::uint32_t unknown_1c;          // +0x1c
    std::uint32_t unknown_20;          // +0x20
    std::uint32_t stride;              // +0x24
    std::uint32_t scanline;            // +0x28
    std::uint32_t unknown_2c;          // +0x2c
    std::uintptr_t metadata;           // +0x30, MiMetadata* held by a shared_ptr
    std::uintptr_t metadata_control;   // +0x38, that shared_ptr's control block
    std::uintptr_t object_40;          // +0x40
    std::uintptr_t object_48;          // +0x48
    std::uintptr_t object_50;          // +0x50
    std::uintptr_t object_58;          // +0x58
    std::uint32_t num_planes;          // +0x60
    std::int32_t fd_slots[3];          // +0x64, +0x68, +0x6c
    std::uintptr_t plane_ptrs[3];      // +0x70, +0x78, +0x80
    std::uintptr_t native_handle;      // +0x88, stock filter gralloc path
    std::uintptr_t opaque_tail[9];     // +0x90..+0xd7
};
static_assert(std::is_standard_layout_v<ImageParams>);
static_assert(sizeof(ImageParams) == 0xd8);
static_assert(offsetof(ImageParams, format) == 0x00);
static_assert(offsetof(ImageParams, width) == 0x04);
static_assert(offsetof(ImageParams, height) == 0x08);
static_assert(offsetof(ImageParams, stride) == 0x24);
static_assert(offsetof(ImageParams, scanline) == 0x28);
static_assert(offsetof(ImageParams, metadata) == 0x30);
static_assert(offsetof(ImageParams, num_planes) == 0x60);
static_assert(offsetof(ImageParams, fd_slots) == 0x64);
static_assert(offsetof(ImageParams, plane_ptrs) == 0x70);
static_assert(offsetof(ImageParams, native_handle) == 0x88);

// libc++ map objects in the OS4 engine are three qwords (0x18 bytes).  Keep
// this representation opaque: it is safe for offset/view work without
// pretending that a host-side std::map with a different ABI is compatible.
struct LibcxxMap24 {
    std::uintptr_t words[3];
};
static_assert(sizeof(LibcxxMap24) == 0x18);

// ProcessRequestInfo (V1) prefix.  filter.so:0xc218 reads map objects at +0
// and +0x18.  The host object has trailing state beyond this proven prefix.
struct ProcessRequestInfoPrefix {
    LibcxxMap24 input_buffers;         // +0x00
    LibcxxMap24 output_buffers;        // +0x18
};
static_assert(offsetof(ProcessRequestInfoPrefix, input_buffers) == 0x00);
static_assert(offsetof(ProcessRequestInfoPrefix, output_buffers) == 0x18);

// ProcessRequestInfoV2 prefix.  Engine-side V2 construction passes a pointer
// to this object (libmialgoengine.so:0x4d994).  A plugin implementation found
// in the engine family loads the first map at +0 and reads a scalar at +0x18.
// The scalar's semantic type/name and all trailing fields remain unproven.
struct ProcessRequestInfoV2Prefix {
    LibcxxMap24 input_buffers;         // +0x00; map value is vector<ImageParams>
    std::uint32_t unknown_18;          // +0x18; scalar load is proven, meaning not
    std::uint32_t unknown_1c;          // +0x1c
    std::uintptr_t unknown_20;         // +0x20
    std::uintptr_t unknown_28;         // +0x28
};
static_assert(offsetof(ProcessRequestInfoV2Prefix, input_buffers) == 0x00);
static_assert(offsetof(ProcessRequestInfoV2Prefix, unknown_18) == 0x18);
// Deliberately no sizeof assertion: this is a prefix view, not a complete V2
// object definition.

// PluginWraper slots, relative to the object's vptr address point (the vptr
// equals ztv + 0x10).  Recovered from the stock 15 Pro plugins after decoding
// the APS2 packed DT_ANDROID_RELA section of /odm:
//   com.xiaomi.plugin.filter.so  _ZTV12FilterPlugin    = 0x20008, 160 bytes
//   com.xiaomi.plugin.pixman.so  _ZTV12PixmanPlugin    = 0x10068, 160 bytes
// Both are exactly 18 virtual slots, and the pixman roster names the slots the
// filter keeps anonymous.  Self-checked against the engine dispatch sites
// (MiaNode::isEnable -> +0x48, MiaNode::setRequestPrivMessage -> +0x58,
// MiaNode::deInit -> +0x60/+0x70) and against the trivial stock bodies
// (0xe3a8 = return 0, 0xe538 = no-op, 0xe540 = return -1, 0xe5cc = return 1).
struct PluginWraperVtable {
    static constexpr std::size_t initialize = 0x00;
    static constexpr std::size_t pre_process = 0x08;
    static constexpr std::size_t need_pre_process = 0x10;
    static constexpr std::size_t process_request_v1 = 0x18;
    static constexpr std::size_t process_request_v2 = 0x20;
    static constexpr std::size_t customize_out_buffer_formats = 0x28;
    static constexpr std::size_t post_process = 0x30;
    static constexpr std::size_t flush_request = 0x38;
    static constexpr std::size_t destroy = 0x40;
    static constexpr std::size_t is_enabled = 0x48;
    static constexpr std::size_t reset = 0x50;
    static constexpr std::size_t set_request_priv_message = 0x58;
    static constexpr std::size_t request_priv_message = 0x60;
    static constexpr std::size_t complete_destructor = 0x68;
    static constexpr std::size_t deleting_destructor = 0x70;
    static constexpr std::size_t convert_image_params = 0x78;
    static constexpr std::size_t is_pre_processed = 0x80;
    static constexpr std::size_t support_pre_process = 0x88;
};
static constexpr std::size_t kPluginWraperSlots = 18;

// Provider slots, relative to the provider object's vptr address point.  The
// provider ZTV has the Itanium D1/D0 destructor entries at +0/+8.  Engine
// call sites load create at +0x20 and getName at +0x28; the intervening slots
// are getVersion and getType at +0x10/+0x18.
struct ProviderVtable {
    static constexpr std::size_t complete_destructor = 0x00;
    static constexpr std::size_t deleting_destructor = 0x08;
    static constexpr std::size_t get_interface_version = 0x10;
    static constexpr std::size_t get_provider_type = 0x18;
    static constexpr std::size_t create = 0x20;
    static constexpr std::size_t get_name = 0x28;
};

static constexpr std::uint32_t kPlumaInterfaceVersion = 1;
static constexpr std::uint32_t kPlumaLowestVersion = 1;

} // namespace m3::mivi14
