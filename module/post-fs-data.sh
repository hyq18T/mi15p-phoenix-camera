#!/system/bin/sh

# All root managers stage the merged ODM tree themselves: /system/odm does not
# exist on devices whose ODM lives in its own partition, so Magisk magic mount
# cannot reach /odm from the system/odm tree. The staged tree is made of real
# copies, because per-file bind mounts inside the module directory do not
# survive boot.

MODDIR="${0%/*}"
LOG="$MODDIR/mount.log"
exec >"$LOG" 2>&1
set -u

fail() {
  echo "ERROR: $*"
  touch "$MODDIR/mount_failed"
  exit 1
}
ROOT_FAMILY_FILE="$MODDIR/.phoenix-root-family"
ROOT_FAMILY=""
if [ -r "$ROOT_FAMILY_FILE" ]; then
  IFS= read -r ROOT_FAMILY < "$ROOT_FAMILY_FILE" || true
fi
case "$ROOT_FAMILY" in
  ksu) BB=/data/adb/ksu/bin/busybox ;;
  magisk) BB=/data/adb/magisk/busybox ;;
  apatch) BB=/data/adb/ap/bin/busybox ;;
  *)
    fail "缺少或无效的 Root 管理器记录：${ROOT_FAMILY:-未知}"
    ;;
esac

[ -x "$BB" ] || fail "${ROOT_FAMILY} BusyBox 不可用：$BB"
echo "Root 管理器：${ROOT_FAMILY}，BusyBox=$BB"

rm -f "$MODDIR/mount_failed"


case "$ROOT_FAMILY" in
  magisk|ksu|apatch)
    echo "${ROOT_FAMILY}：执行受控 ODM 子树合并"
    ;;
esac

stage_merged_tree() {
  local source_dir="$1"
  local lower_dir="$2"
  local merge_dir="$3"
  # Real copies, not bind mounts: per-file bind mounts created inside the module
  # directory do not survive boot on haotian, which left /odm serving empty
  # placeholder files. Copy the device tree first, then overlay the module tree.
  rm -rf "$merge_dir"
  mkdir -p "$merge_dir" || fail "create merge directory: $merge_dir"
  cp -a "$lower_dir/." "$merge_dir/" || fail "copy device tree: $lower_dir"
  cp -a "$source_dir/." "$merge_dir/" || fail "copy module tree: $source_dir"
  chcon -R "$MERGE_CONTEXT" "$merge_dir" || fail "label merge directory: $merge_dir"
}

rm -rf "$MODDIR/.merge"
mkdir -p "$MODDIR/.merge/camera" || fail "create camera merge root"

case "$ROOT_FAMILY" in
  magisk) MODULE_ODM="$MODDIR/system/odm" ;;
  *) MODULE_ODM="$MODDIR/payload/odm" ;;
esac
[ -d "$MODULE_ODM/etc/camera/videofilter" ] || fail "installer did not stage video filter directory"
[ -d /odm/etc/camera/videofilter ] || fail "target video filter directory is missing"

MERGE_CONTEXT=u:object_r:vendor_configs_file:s0
chcon -R u:object_r:vendor_configs_file:s0 "$MODULE_ODM/etc/camera/videofilter" || fail "label video filter assets"
stage_merged_tree "$MODULE_ODM/etc/camera/videofilter" /odm/etc/camera/videofilter "$MODDIR/.merge/camera/videofilter"
"$BB" mount -o bind "$MODDIR/.merge/camera/videofilter" /odm/etc/camera/videofilter || fail "activate video filter directory"

[ -d "$MODULE_ODM/etc/camera/xiaomi/watermark" ] || fail "installer did not stage watermark directory"
[ -d /odm/etc/camera/xiaomi/watermark ] || fail "target watermark directory is missing"
chcon -R u:object_r:vendor_configs_file:s0 "$MODULE_ODM/etc/camera/xiaomi/watermark" || fail "label watermark assets"
stage_merged_tree "$MODULE_ODM/etc/camera/xiaomi/watermark" /odm/etc/camera/xiaomi/watermark "$MODDIR/.merge/camera/xiaomi/watermark"
"$BB" mount -o bind "$MODDIR/.merge/camera/xiaomi/watermark" /odm/etc/camera/xiaomi/watermark || fail "activate watermark directory"

echo "Phoenix ODM assets mounted successfully"
exit 0
