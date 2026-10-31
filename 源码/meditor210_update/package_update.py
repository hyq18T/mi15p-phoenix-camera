"""替换二合一模块中的 LSP，内置官方相册编辑器，并保持原相机/M3 载荷。"""

import argparse
import hashlib
import json
import re
import zipfile
from pathlib import Path


EDITOR_CODE = 210994308
LSP_CODE = 2010503
MODULE_CODE = 2013004
MODULE_VERSION = "Phoenix-1.3.0-M3-r17-MEditor210-r3"
EDITOR_NAME = "MediaEditor_2.10.43.0.8.apk"
LSP_NAME = "Phoenix_LSP_AllInOne-1.3.0.apk"


def sha256_file(path):
    with path.open("rb") as stream:
        return hashlib.file_digest(stream, "sha256").hexdigest()


def change_once(text, old, new, label):
    if text.count(old) != 1:
        raise ValueError(f"{label} 的预期修改位置不唯一")
    return text.replace(old, new, 1)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--base-module", required=True, type=Path)
    parser.add_argument("--lsp-apk", required=True, type=Path)
    parser.add_argument("--editor-apk", required=True, type=Path)
    parser.add_argument("--output", required=True, type=Path)
    parser.add_argument("--module-source", required=True, type=Path)
    parser.add_argument("--report", required=True, type=Path)
    args = parser.parse_args()
    if args.output.exists() or args.module_source.exists():
        raise ValueError("输出包或模块源码目录已存在，请指定新路径")
    if sha256_file(args.editor_apk) != "b76bf2699188326c0a5f621e2ce0399a25f2eb5250a4170ccd80127ee42953a5":
        raise ValueError("相册编辑器不是本次核对的官方 2.10.43.0.8 APK")
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.module_source.mkdir(parents=True)
    changed = {}
    with zipfile.ZipFile(args.base_module) as old:
        prop = old.read("module.prop").decode("utf-8")
        if "id=phoenix_camera_15pro\n" not in prop:
            raise ValueError("原模块 ID 不匹配")
        prop = re.sub(r"(?m)^version=.*$", "version=" + MODULE_VERSION, prop)
        prop = re.sub(r"(?m)^versionCode=.*$", "versionCode=" + str(MODULE_CODE), prop)
        prop = re.sub(r"(?m)^name=.*$", "name=Phoenix 15 Pro 相机增强", prop)
        prop = re.sub(r"(?m)^description=.*$", "description=相机/M3/原色；相册2.10 AI与调色盘；内置相机、编辑器和三合一LSP。", prop)
        changed["module.prop"] = prop.encode("utf-8")

        customize = old.read("customize.sh").decode("utf-8")
        customize = customize.replace('VERSION="Phoenix-1.3.0-M3-r17"', 'VERSION="' + MODULE_VERSION + '"', 1)
        customize = change_once(customize, 'AUDIT="$MODPATH/install-audit.log"',
            'EDITOR_APK="$MODPATH/' + EDITOR_NAME + '"\nEDITOR_PACKAGE="com.miui.mediaeditor"\nAUDIT="$MODPATH/install-audit.log"', "编辑器变量")
        customize = change_once(customize, '    com.prometheus.camera.rev) install_label="Prometheus LSP" ;;',
            '    com.prometheus.camera.rev) install_label="Prometheus LSP" ;;\n    com.miui.mediaeditor) install_label="相册编辑器 2.10" ;;', "安装标签")
        customize = change_once(customize, '[ -f "$CAMERA_APK" ] || fail "缺少相机 APK"',
            '[ -f "$CAMERA_APK" ] || fail "缺少相机 APK"\n[ -f "$EDITOR_APK" ] || fail "缺少相册编辑器 APK"\n[ "$(getprop ro.product.device)" = haotian ] || fail "本包仅适用于小米 15 Pro（haotian）"', "输入与机型检查")
        editor_stage = '''stage "升级相册编辑器 2.10.43.0.8"
EDITOR_CODE_NOW="$(cmd package list packages --show-versioncode "$EDITOR_PACKAGE" | "$BB" awk -v p="package:$EDITOR_PACKAGE" '$1 == p { sub("versionCode:", "", $2); print $2 }')"
case "$EDITOR_CODE_NOW" in ''|*[!0-9]*) fail "无法读取当前相册编辑器版本" ;; esac
[ "$EDITOR_CODE_NOW" -le 210994308 ] || fail "已安装更高版本相册编辑器，拒绝自动降级"
if [ "$EDITOR_CODE_NOW" -eq 210994308 ]; then
  audit "通过" "相册编辑器已是 2.10.43.0.8，保留现有安装"
else
  install_apk "$EDITOR_PACKAGE" "$EDITOR_APK"
fi

stage "合并旧 M3 模块"'''
        customize = change_once(customize, 'stage "合并旧 M3 模块"', editor_stage, "编辑器升级阶段")
        changed["customize.sh"] = customize.encode("utf-8")

        check = old.read("install-self-check.sh").decode("utf-8")
        check, replacements = re.subn(r'(?m)^LSP_CODE="?2010400"?$', 'LSP_CODE="' + str(LSP_CODE) + '"', check)
        if replacements != 1:
            raise ValueError("LSP 版本自检修改位置不唯一")
        check = check.replace('for package in com.android.camera com.prometheus.camera.rev; do',
                              'for package in com.android.camera com.prometheus.camera.rev com.miui.mediaeditor; do', 1)
        check = change_once(check, '    com.prometheus.camera.rev) expected_version="versionCode:$LSP_CODE" ;;',
            '    com.prometheus.camera.rev) expected_version="versionCode:$LSP_CODE" ;;\n    com.miui.mediaeditor) expected_version="versionCode:210994308" ;;', "编辑器版本自检")
        check = change_once(check, '    com.prometheus.camera.rev) package_label="Prometheus LSP" ;;',
            '    com.prometheus.camera.rev) package_label="Prometheus LSP" ;;\n    com.miui.mediaeditor) package_label="相册编辑器 2.10" ;;', "编辑器自检标签")
        check = change_once(check, 'for file in "$MODROOT/$CAMERA_APK" "$MODROOT/$LSP_APK" \\',
            'for file in "$MODROOT/$CAMERA_APK" "$MODROOT/$LSP_APK" "$MODROOT/' + EDITOR_NAME + '" \\', "编辑器文件自检")
        changed["install-self-check.sh"] = check.encode("utf-8")

        unchanged_hashes = {}
        with zipfile.ZipFile(args.output, "w", compression=zipfile.ZIP_DEFLATED, compresslevel=6) as out:
            for info in old.infolist():
                name = info.filename
                if name.startswith("/") or ".." in Path(name).parts:
                    raise ValueError("原模块存在越界路径")
                if name == LSP_NAME:
                    out.write(args.lsp_apk, name, compress_type=zipfile.ZIP_DEFLATED)
                    continue
                data = changed.get(name)
                if data is None:
                    data = old.read(name)
                    if not info.is_dir():
                        unchanged_hashes[name] = hashlib.sha256(data).hexdigest()
                out.writestr(info, data)
                if not name.endswith(".apk") and not info.is_dir():
                    target = args.module_source / name
                    target.parent.mkdir(parents=True, exist_ok=True)
                    target.write_bytes(data)
            out.write(args.editor_apk, EDITOR_NAME, compress_type=zipfile.ZIP_DEFLATED)

    with zipfile.ZipFile(args.output) as out:
        bad = out.testzip()
        if bad:
            raise ValueError("ZIP 数据完整性检查失败：" + bad)
        for name, expected in unchanged_hashes.items():
            if hashlib.sha256(out.read(name)).hexdigest() != expected:
                raise ValueError("原载荷发生意外改动：" + name)
        for name, source in ((LSP_NAME, args.lsp_apk), (EDITOR_NAME, args.editor_apk)):
            with out.open(name) as stream:
                actual = hashlib.file_digest(stream, "sha256").hexdigest()
            if actual != sha256_file(source):
                raise ValueError("包内 APK 摘要不匹配：" + name)
        apk_files = {name: out.getinfo(name).file_size for name in out.namelist() if name.endswith(".apk")}
    report = {
        "status": "PASS",
        "module_version": MODULE_VERSION,
        "module_version_code": MODULE_CODE,
        "lsp_version_code": LSP_CODE,
        "editor_version_code": EDITOR_CODE,
        "output": str(args.output.resolve()),
        "bytes": args.output.stat().st_size,
        "sha256": sha256_file(args.output),
        "embedded_apks": apk_files,
        "modified_scripts_and_metadata": sorted(changed),
        "unchanged_payload_file_count": len(unchanged_hashes),
        "camera_and_m3_payloads_identical": True,
        "editor_data_clear_operations_added": False,
    }
    args.report.parent.mkdir(parents=True, exist_ok=True)
    args.report.write_text(json.dumps(report, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(json.dumps(report, ensure_ascii=False, indent=2))


if __name__ == "__main__":
    main()
