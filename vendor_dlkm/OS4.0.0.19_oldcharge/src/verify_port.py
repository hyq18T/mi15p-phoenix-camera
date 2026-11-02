#!/usr/bin/env python3
import argparse
import hashlib
import os
import sys

import analyze_abi


def sha256_file(path):
    digest = hashlib.sha256()
    with open(path, "rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def scan_tree(root):
    result = {}
    for directory, _, filenames in os.walk(root):
        for filename in filenames:
            path = os.path.join(directory, filename)
            relative = os.path.relpath(path, root).replace(os.sep, "/")
            result[relative] = {
                "mode": os.lstat(path).st_mode & 0o7777,
                "size": os.path.getsize(path),
                "sha256": sha256_file(path),
            }
    return result


def unique_import_crc(mapping, name):
    values = set(mapping.get(name, {}).keys())
    return next(iter(values)) if len(values) == 1 else None


def unique_export_crc(mapping, name):
    values = set(mapping.get(name, {}).values())
    return next(iter(values)) if len(values) == 1 else None


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("old_root")
    parser.add_argument("author16_root")
    parser.add_argument("stock19_root")
    parser.add_argument("patched_root")
    args = parser.parse_args()

    expected = set(analyze_abi.REPLACED_MODULES)
    old_modules = analyze_abi.module_paths(args.old_root)
    author_modules = analyze_abi.module_paths(args.author16_root)
    stock_modules = analyze_abi.module_paths(args.stock19_root)
    patched_module_dir = os.path.join(args.patched_root, "lib", "modules")
    if os.path.isdir(patched_module_dir):
        patched_modules = analyze_abi.module_paths(args.patched_root)
    else:
        patched_modules = {
            name: os.path.join(args.patched_root, name)
            for name in sorted(os.listdir(args.patched_root))
            if name.endswith(".ko")
        }

    failures = []
    if set(patched_modules) != expected:
        failures.append(
            "patched module set differs: "
            f"missing={sorted(expected - set(patched_modules))} "
            f"extra={sorted(set(patched_modules) - expected)}"
        )

    stock_imports, stock_exports = analyze_abi.build_global_versions(stock_modules)
    patched_exports = {}
    patched_elves = {}
    for module in sorted(expected):
        if module not in patched_modules:
            continue
        elf = analyze_abi.Elf(patched_modules[module])
        patched_elves[module] = elf
        for name, info in elf.export_crcs().items():
            patched_exports.setdefault(name, {})[module] = info["crc"]

    for module in sorted(expected):
        if module not in patched_modules:
            continue
        patched = patched_elves[module]
        stock = analyze_abi.Elf(stock_modules[module])
        old_name = "sc8581.ko" if module == "sc8581_sy6541.ko" else module
        old = analyze_abi.Elf(old_modules[old_name])
        author = analyze_abi.Elf(author_modules[module])

        if patched.section_bytes(".text") != old.section_bytes(".text"):
            failures.append(f"{module}: .text differs from OS3 reference")
        if patched.section_bytes(".text") != author.section_bytes(".text"):
            failures.append(f"{module}: .text differs from author source")
        if patched.modinfo().get("vermagic") != stock.modinfo().get("vermagic"):
            failures.append(f"{module}: vermagic differs from stock 19")

        author_data = bytes(author.data)
        patched_data = bytes(patched.data)
        if len(author_data) != len(patched_data):
            failures.append(f"{module}: patch changed file size")
        changed_offsets = {
            index
            for index, (before, after) in enumerate(zip(author_data, patched_data))
            if before != after
        }
        allowed_offsets = set()
        for item in author.import_versions():
            allowed_offsets.update(
                range(
                    author.section("__versions")["offset"] + item["offset"],
                    author.section("__versions")["offset"] + item["offset"] + 8,
                )
            )
        for info in author.export_crcs().values():
            allowed_offsets.update(range(info["offset"], info["offset"] + 4))
        unexpected_offsets = changed_offsets - allowed_offsets
        if unexpected_offsets:
            failures.append(
                f"{module}: bytes changed outside CRC fields: "
                f"{sorted(unexpected_offsets)[:10]}"
            )

        for item in patched.import_versions():
            expected_crc = unique_export_crc(patched_exports, item["name"])
            if expected_crc is None:
                expected_crc = unique_import_crc(stock_imports, item["name"])
            if expected_crc is None:
                expected_crc = unique_export_crc(stock_exports, item["name"])
            if expected_crc is not None and item["crc"] != expected_crc:
                failures.append(
                    f"{module}: unresolved import CRC for {item['name']}: "
                    f"{item['crc']:#010x} != {expected_crc:#010x}"
                )

        for name, info in patched.export_crcs().items():
            expected_crc = unique_export_crc(stock_exports, name)
            if expected_crc is None:
                expected_crc = unique_import_crc(stock_imports, name)
            if expected_crc is not None and info["crc"] != expected_crc:
                failures.append(
                    f"{module}: export CRC for {name}: "
                    f"{info['crc']:#010x} != {expected_crc:#010x}"
                )

        print(
            f"OK {module} "
            f"size={len(patched_data)} "
            f"text_sha256={hashlib.sha256(patched.section_bytes('.text')).hexdigest()} "
            f"patched_sha256={sha256_file(patched_modules[module])}"
        )

    if failures:
        for failure in failures:
            print(f"FAIL {failure}")
        return 1

    print(f"modules={len(expected)} failures=0")
    return 0


if __name__ == "__main__":
    sys.exit(main())
