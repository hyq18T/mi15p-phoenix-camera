#!/system/bin/sh

# 二合一挂载顺序：先挂 M3 的 xiaomi/plugins，再由相机脚本把
# videofilter 与 watermark 精确挂到 /odm 对应子目录，避免互相覆盖。

MODDIR="${0%/*}"
LOG="$MODDIR/mount-all.log"
: >"$LOG"

echo "=== M3 ===" >>"$LOG"
sh "$MODDIR/post-fs-data-m3.sh"
M3_STATUS=$?
echo "M3 status=$M3_STATUS" >>"$LOG"

echo "=== camera ===" >>"$LOG"
sh "$MODDIR/post-fs-data-camera.sh"
CAM_STATUS=$?
echo "camera status=$CAM_STATUS" >>"$LOG"

if [ "$M3_STATUS" -ne 0 ] || [ "$CAM_STATUS" -ne 0 ]; then
  touch "$MODDIR/mount_failed"
  exit 1
fi
exit 0
