#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
用法:
  build_oldcharge19.sh <官方OS4.0.0.19 vendor_dlkm.img> <28个KO目录> <输出目录> [avbtool]

环境变量:
  AVBTOOL   avbtool 可执行文件路径；第四个参数优先。
EOF
}

if [[ $# -lt 3 || $# -gt 4 ]]; then
  usage >&2
  exit 2
fi

official="$1"
modules_dir="$2"
output_dir="$3"
avbtool="${4:-${AVBTOOL:-avbtool}}"
script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
contexts="$script_dir/file_contexts_vendor_dlkm.txt"

expected_official_sha="e64981c83da1ef39add275c11f460561c2d5e792b75eb7ac12a4c02251851500"
partition_size="88707072"
uuid="e3611c9c-5568-5aed-97f3-4806df331338"
salt="a8367d32a09ff6ce8b8687bbb571a7f78a728c72e148bf4d6770c9cce6a1e095"
fingerprint="Xiaomi/haotian/haotian:15/AQ3A.250226.002/OS4.0.0.19.XOBCN:user/release-keys"
output_name="vendor_dlkm_oldcharge_OS4.0.0.19.img"

for command_name in fsck.erofs mkfs.erofs dump.erofs python3 sha256sum install; do
  command -v "$command_name" >/dev/null 2>&1 || {
    echo "ERROR: 缺少命令: $command_name" >&2
    exit 1
  }
done

[[ -f "$official" ]] || {
  echo "ERROR: 找不到官方镜像: $official" >&2
  exit 1
}
[[ -d "$modules_dir" ]] || {
  echo "ERROR: 找不到 KO 目录: $modules_dir" >&2
  exit 1
}
[[ -f "$contexts" ]] || {
  echo "ERROR: 找不到 file contexts: $contexts" >&2
  exit 1
}

mapfile -t module_files < <(find "$modules_dir" -maxdepth 1 -type f -name '*.ko' -print | sort)
if [[ ${#module_files[@]} -ne 28 ]]; then
  echo "ERROR: KO 数量不是 28，实际为 ${#module_files[@]}" >&2
  exit 1
fi

actual_official_sha="$(sha256sum "$official" | awk '{print $1}')"
if [[ "$actual_official_sha" != "$expected_official_sha" ]]; then
  echo "ERROR: 官方镜像 SHA-256 不匹配" >&2
  echo "expected=$expected_official_sha" >&2
  echo "actual=$actual_official_sha" >&2
  exit 1
fi

work="$(mktemp -d "${TMPDIR:-/tmp}/vendor_dlkm_oldcharge19.XXXXXX")"
cleanup() {
  rm -rf -- "$work"
}
trap cleanup EXIT

mkdir -p "$work/baseline" "$work/build" "$work/verify" "$output_dir"

PYTHONPYCACHEPREFIX="$work/pycache" \
  python3 -m py_compile \
  "$script_dir/analyze_abi.py" \
  "$script_dir/port_modules.py" \
  "$script_dir/verify_port.py" \
  "$script_dir/verify_image_tree.py" \
  "$script_dir/verify_release.py"

fsck.erofs --extract="$work/baseline" --preserve "$official" \
  >"$work/extract_baseline.txt" 2>&1
fsck.erofs --extract="$work/build" --preserve "$official" \
  >"$work/extract_build.txt" 2>&1

for module in "${module_files[@]}"; do
  install -m 644 "$module" "$work/build/lib/modules/$(basename "$module")"
done

mkfs.erofs \
  -b 4096 \
  -z lz4hc,9 \
  -C 4096 \
  -T 1230768000 \
  --preserve-mtime \
  -U "$uuid" \
  --all-root \
  --file-contexts="$contexts" \
  "$work/$output_name" \
  "$work/build" \
  >"$work/mkfs_erofs.log" 2>&1

"$avbtool" add_hashtree_footer \
  --image "$work/$output_name" \
  --partition_size "$partition_size" \
  --partition_name vendor_dlkm \
  --hash_algorithm sha256 \
  --salt "$salt" \
  --block_size 4096 \
  --fec_num_roots 2 \
  --algorithm NONE \
  --rollback_index 0 \
  --prop com.android.build.vendor_dlkm.os_version:15 \
  --prop "com.android.build.vendor_dlkm.fingerprint:$fingerprint" \
  >"$work/add_avb_footer.txt" 2>&1

fsck.erofs --extract="$work/verify" --preserve "$work/$output_name" \
  >"$work/extract_verify.txt" 2>&1
python3 "$script_dir/verify_image_tree.py" \
  "$work/baseline" "$work/build" "$work/verify" \
  >"$work/verify_image_tree.txt"
"$avbtool" verify_image --image "$work/$output_name" \
  >"$work/verify_avb.txt" 2>&1
"$avbtool" info_image --image "$work/$output_name" \
  >"$work/avb_info.txt"
dump.erofs -s "$work/$output_name" >"$work/erofs_info.txt"

install -m 644 "$work/$output_name" "$output_dir/$output_name"
install -m 644 "$official" "$output_dir/vendor_dlkm_OS4.0.0.19_官方回刷.img"
install -m 644 "$work/verify_image_tree.txt" "$output_dir/verify_image_tree.txt"
install -m 644 "$work/verify_avb.txt" "$output_dir/verify_avb.txt"
install -m 644 "$work/avb_info.txt" "$output_dir/avb_info.txt"
install -m 644 "$work/erofs_info.txt" "$output_dir/erofs_info.txt"
install -m 644 "$work/mkfs_erofs.log" "$output_dir/mkfs_erofs.log"

echo "BUILD_OK"
echo "output=$output_dir/$output_name"
sha256sum "$output_dir/$output_name"
stat -c "size=%s" "$output_dir/$output_name"
