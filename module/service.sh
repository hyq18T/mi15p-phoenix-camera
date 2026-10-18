#!/system/bin/sh

MODDIR="${0%/*}"
LOG="$MODDIR/service-all.log"
: >"$LOG"

echo "start M3 service" >>"$LOG"
sh "$MODDIR/service-m3.sh" &
echo "M3 service pid=$!" >>"$LOG"

echo "start camera service" >>"$LOG"
sh "$MODDIR/service-camera.sh"
CAM_STATUS=$?
echo "camera service exited=$CAM_STATUS" >>"$LOG"
exit "$CAM_STATUS"
