"""回填源码未改动的 dex，保留 M3、NaturalTuning 和两个辅助 dex 的原字节。"""

import argparse
import hashlib
import json
import re
import zipfile
from pathlib import Path


def tree_hashes(folder):
    return {str(p.relative_to(folder)).replace("\\", "/"): hashlib.sha256(p.read_bytes()).hexdigest()
            for p in folder.rglob("*.smali")}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for option in ("baseline-apk", "baseline-tree", "merged-tree", "unsigned", "report"):
        parser.add_argument("--" + option, required=True, type=Path)
    args = parser.parse_args()
    preserved = {}
    with zipfile.ZipFile(args.baseline_apk) as original:
        for folder in args.baseline_tree.iterdir():
            if not folder.is_dir() or not re.fullmatch(r"smali(?:_classes\d+)?", folder.name):
                continue
            newer = args.merged_tree / folder.name
            if newer.is_dir() and tree_hashes(folder) == tree_hashes(newer):
                name = "classes.dex" if folder.name == "smali" else folder.name.removeprefix("smali_") + ".dex"
                preserved[name] = original.read(name)
        for name in ("assets.dex", "assets/video_quality.dex"):
            preserved[name] = original.read(name)
    temporary = args.unsigned.with_suffix(".preserve.pending.apk")
    with zipfile.ZipFile(args.unsigned) as compiled, zipfile.ZipFile(temporary, "w") as patched:
        seen = set()
        for entry in compiled.infolist():
            patched.writestr(entry, preserved.get(entry.filename, compiled.read(entry.filename)))
            seen.add(entry.filename)
        for name, data in preserved.items():
            if name not in seen:
                info = zipfile.ZipInfo(name)
                info.compress_type = zipfile.ZIP_STORED
                info.external_attr = 0o100644 << 16
                patched.writestr(info, data)
    with zipfile.ZipFile(temporary) as patched:
        assert patched.testzip() is None
        for name, data in preserved.items():
            assert patched.read(name) == data
    temporary.replace(args.unsigned)
    report = {"status": "PASS", "preserved_dex": {name: hashlib.sha256(data).hexdigest() for name, data in preserved.items()}}
    args.report.write_text(json.dumps(report, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(json.dumps(report, ensure_ascii=False, indent=2))


if __name__ == "__main__":
    main()
