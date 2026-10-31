"""将作者的相册 2.10 更新合入现有 15 Pro 三合一 LSP，保留相机修复。"""

import argparse
import hashlib
import json
import re
import shutil
import xml.etree.ElementTree as ET
import zipfile
from pathlib import Path


FAMILIES = (
    "com/prometheus/camera/rev/GalleryV24043Bridge",
    "com/prometheus/camera/rev/MediaEditorWatermarkBridge",
    "com/prometheus/camera/rev/MediaEditorAnchors",
    "com/prometheus/camera/rev/MeAi",
    "com/prometheus/camera/rev/MeNav",
    "com/prometheus/camera/rev/MeProbe",
    "com/prometheus/camera/rev/EvPanelGuard",
    "com/prometheus/camera/rev/MeditorExtrasEntry",
    "com/prometheus/camera/rev/PresetLutInstaller",
    "com/prometheus/camera/filters/PresetLutStore",
)
ANDROID = "{http://schemas.android.com/apk/res/android}"
DESCRIPTOR = re.compile(r"^\.class[^\n]*?\s+(L[^;]+;)$", re.MULTILINE)
INTERNAL_REF = re.compile(r"L(?:com/prometheus/camera|com/nezha/q0fix|com/ishtar/mistfix)/[^;\s]+;")


def classes(tree):
    result = {}
    for group in tree.iterdir():
        if not group.is_dir() or not re.fullmatch(r"smali(?:_classes\d+)?", group.name):
            continue
        for path in group.rglob("*.smali"):
            text = path.read_text(encoding="utf-8")
            match = DESCRIPTOR.search(text)
            if not match:
                raise ValueError(f"无法读取 class 定义：{path}")
            descriptor = match[1]
            if descriptor in result:
                raise ValueError(f"主 dex 中重复定义：{descriptor}")
            result[descriptor] = (path, text)
    return result


def selected(descriptor):
    name = descriptor[1:-1]
    return any(name == family or name.startswith(family + "$") for family in FAMILIES)


def missing_refs(index):
    return {ref for _, text in index.values() for ref in INTERNAL_REF.findall(text)} - index.keys()


def sha256(path):
    with path.open("rb") as stream:
        return hashlib.file_digest(stream, "sha256").hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--baseline-tree", type=Path, required=True)
    parser.add_argument("--baseline-apk", type=Path, required=True)
    parser.add_argument("--author-tree", type=Path, required=True)
    parser.add_argument("--editor-tree", type=Path, required=True)
    parser.add_argument("--output-tree", type=Path, required=True)
    parser.add_argument("--report", type=Path, required=True)
    args = parser.parse_args()
    if args.output_tree.exists():
        raise ValueError("输出目录已存在；请指定新的构建目录")
    baseline = classes(args.baseline_tree)
    author = classes(args.author_tree)
    donors = {key: value for key, value in author.items() if selected(key)}
    if not donors:
        raise ValueError("作者包中没有找到相册更新类")
    extras = author["Lcom/prometheus/camera/rev/MeditorExtrasEntry;"][1]
    if ".field private static final ENABLE_AREC:Z = false" not in extras:
        raise ValueError("必须使用关闭 13U 录音修复的通用版")
    if ".field private static final ENABLE_Q0FIX:Z = false" not in extras:
        raise ValueError("必须使用关闭 13U Q0 修复的通用版")

    # Apktool 将 assets.dex 与 assets/video_quality.dex 都反编译到 smali_assets，
    # 回编译会产生重复类。这两份辅助 dex 不在本次修改范围，按原字节保留。
    shutil.copytree(args.baseline_tree, args.output_tree,
                    ignore=shutil.ignore_patterns("smali_assets", "build", "dist"))
    opaque_dex = {}
    with zipfile.ZipFile(args.baseline_apk) as archive:
        for name in ("assets.dex", "assets/video_quality.dex"):
            data = archive.read(name)
            target = args.output_tree / ("unknown" if name == "assets.dex" else "") / name
            target.parent.mkdir(parents=True, exist_ok=True)
            target.write_bytes(data)
            opaque_dex[name] = hashlib.sha256(data).hexdigest()
    # 仅替换正在升级的相册类族，避免遗留旧匿名类引用新的 synthetic 方法。
    copied = classes(args.output_tree)
    old_selected = {key: value for key, value in copied.items() if selected(key)}
    for path, _ in old_selected.values():
        path.unlink()
    new_group = args.output_tree / "smali_classes14"
    if new_group.exists():
        raise ValueError("smali_classes14 已被占用")
    for descriptor, (source, _) in donors.items():
        target = new_group / (descriptor[1:-1] + ".smali")
        target.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(source, target)

    init_file = args.output_tree / "assets/xposed_init"
    entries = [line.strip() for line in init_file.read_text(encoding="utf-8").splitlines() if line.strip()]
    extra_entry = "com.prometheus.camera.rev.MeditorExtrasEntry"
    if extra_entry not in entries:
        entries.append(extra_entry)
    if len(entries) != len(set(entries)):
        raise ValueError("xposed_init 出现重复入口")
    init_file.write_text("\n".join(entries) + "\n", encoding="utf-8")

    manifest_file = args.output_tree / "AndroidManifest.xml"
    ET.register_namespace("android", ANDROID[1:-1])
    manifest = ET.parse(manifest_file)
    application = manifest.getroot().find("application")
    application.set(ANDROID + "label", "Phoenix 三合一 · 15 Pro · 相册2.10")
    for entry in application.findall("meta-data"):
        if entry.get(ANDROID + "name") == "xposeddescription":
            entry.set(ANDROID + "value", "Phoenix + M3 + NaturalTuning｜相册2.10 AI与调色盘｜槐蔭區2改")
    manifest.write(manifest_file, encoding="utf-8", xml_declaration=True)
    yaml_file = args.output_tree / "apktool.yml"
    yaml_text = yaml_file.read_text(encoding="utf-8")
    yaml_text = re.sub(r"versionCode:.*", "versionCode: 2010500", yaml_text)
    yaml_text = re.sub(r"versionName:.*", "versionName: Phoenix-1.3.0-AllInOne-MEditor210", yaml_text)
    yaml_file.write_text(yaml_text, encoding="utf-8")

    merged = classes(args.output_tree)
    new_missing = missing_refs(merged) - missing_refs(baseline)
    if new_missing:
        raise ValueError(f"新增的未定义模块类：{sorted(new_missing)}")
    preserved = [key for key in baseline if not selected(key)]
    for key in preserved:
        if merged[key][1] != baseline[key][1]:
            raise ValueError(f"非本次更新范围的类发生变化：{key}")
    for key, (_, text) in donors.items():
        if merged[key][1] != text:
            raise ValueError(f"作者相册更新类复制异常：{key}")
    # 对所有 invoke/field 指令核对模块内部符号。框架/宿主 app 的符号由目标版本核验。
    methods = {}
    fields = {}
    supers = {}
    for key, (_, text) in merged.items():
        methods[key] = set(re.findall(r"^\.method[^\n]*?\s+(\S+\([^\n]*?\)\S+)\s*$", text, re.MULTILINE))
        fields[key] = set(re.findall(r"^\.field[^\n]*?\s+([^\s:]+:[^\s=]+)", text, re.MULTILINE))
        super_match = re.search(r"^\.super (L[^;]+;)", text, re.MULTILINE)
        supers[key] = super_match[1] if super_match else None

    def has_symbol(owner, symbol, symbols):
        seen = set()
        while owner in merged and owner not in seen:
            if symbol in symbols[owner]:
                return True
            seen.add(owner)
            owner = supers.get(owner)
        return owner not in merged  # 外部父类的成员在运行时由框架解析。

    missing_symbols = []
    for key in donors:
        text = merged[key][1]
        for line in text.splitlines():
            if not line.lstrip().startswith(("invoke-", "iget", "iput", "sget", "sput")):
                continue
            match = re.search(r"(L[^;]+;)->([^\s,]+)", line)
            if match and match[1] in merged:
                symbols = methods if "(" in match[2] else fields
                if not has_symbol(match[1], match[2], symbols):
                    missing_symbols.append({"caller": key, "owner": match[1], "symbol": match[2]})
    if missing_symbols:
        raise ValueError(f"相册更新内部符号无法解析：{missing_symbols[:10]}")

    # 从 2.10 APK 的类定义核对实际锚点，不以 dex 字符串引用冒充类定义。
    anchors = author["Lcom/prometheus/camera/rev/MediaEditorAnchors;"][1]
    init = re.search(r"\.method public static init\([^\n]*\n(.*?)\.end method", anchors, re.DOTALL)[1]
    candidates = sorted(set(re.findall(r'const-string[^\n]*"([A-Za-z0-9_$]+(?:\.[A-Za-z0-9_$]+)+)"', init)))
    candidates += ["com.miui.mediaeditor.provider.AiActionProvider", "com.miui.mediaeditor.provider.MediaEditorProviderForGallery", "gt.f", "gt.g"]
    host_anchors = {}
    host_groups = [p for p in args.editor_tree.iterdir() if p.is_dir() and re.fullmatch(r"smali(?:_classes\d+)?", p.name)]
    for candidate in candidates:
        relative = Path(candidate.replace(".", "/") + ".smali")
        match = next((p / relative for p in host_groups if (p / relative).is_file()), None)
        host_anchors[candidate] = str(match.relative_to(args.editor_tree)) if match else None
    if any(value is None for value in host_anchors.values()):
        raise ValueError(f"相册 2.10 中缺失锚点：{[k for k,v in host_anchors.items() if v is None]}")

    report = {
        "status": "PASS",
        "baseline_class_count": len(baseline),
        "author_class_count": len(author),
        "merged_class_count": len(merged),
        "updated_families": list(FAMILIES),
        "replaced_class_count": len(old_selected),
        "imported_class_count": len(donors),
        "preserved_class_count": len(preserved),
        "updated_classes": sorted(donors),
        "new_unresolved_internal_classes": sorted(new_missing),
        "new_unresolved_internal_symbols": missing_symbols,
        "editor_anchors": host_anchors,
        "xposed_entries": entries,
        "lsp_version_code": 2010500,
        "lsp_version_name": "Phoenix-1.3.0-AllInOne-MEditor210",
        "13u_specific_audio_and_q0_hooks_enabled": False,
        "preserved_camera_m3_natural_watermark_assets": True,
        "preserved_opaque_dex_sha256": opaque_dex,
    }
    args.report.parent.mkdir(parents=True, exist_ok=True)
    args.report.write_text(json.dumps(report, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({k: value for k, value in report.items() if k not in ("updated_classes", "editor_anchors", "xposed_entries")}, ensure_ascii=False, indent=2))


if __name__ == "__main__":
    main()
