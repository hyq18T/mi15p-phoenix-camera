#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
用法:
  port_oldcharge.sh <旧版参考KO目录> <当前旧功能KO目录> <目标系统官方KO目录> <输出目录>

旧版参考目录用于核对 .text；当前旧功能KO通常就是本仓库可用的 28 个 KO。
目标系统必须来自与新系统官方 vendor_dlkm.img 同一版本的完整 KO 集合。
EOF
}

if [[ $# -ne 4 ]]; then
  usage >&2
  exit 2
fi

old_reference="$1"
author_oldcharge="$2"
target_stock="$3"
output_dir="$4"
script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

python3 "$script_dir/port_modules.py" \
  "$old_reference" \
  "$author_oldcharge" \
  "$target_stock" \
  "$output_dir"

python3 "$script_dir/verify_port.py" \
  "$old_reference" \
  "$author_oldcharge" \
  "$target_stock" \
  "$output_dir"
