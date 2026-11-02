#!/usr/bin/env python3
import argparse
import hashlib
import os
import struct
import sys

import analyze_abi


def sha256(data):
    return hashlib.sha256(data).hexdigest()


def module_map(root):
    return analyze_abi.module_paths(root)


def unique_import_crc(mapping, name):
    values = set(mapping.get(name, {}).keys())
    if len(values) == 1:
        return next(iter(values))
    return None


def unique_export_crc(mapping, name):
    values = set(mapping.get(name, {}).values())
    if len(values) == 1:
        return next(iter(values))
    return None


def old_text_path(base_modules, module):
    if module == "sc8581_sy6541.ko":
        return base_modules.get("sc8581.ko")
    return base_modules.get(module)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("base")
    parser.add_argument("author16")
    parser.add_argument("stock19")
    parser.add_argument("output")
    args = parser.parse_args()

    base_modules = module_map(args.base)
    author_modules = module_map(args.author16)
    stock_modules = module_map(args.stock19)
    os.makedirs(args.output, exist_ok=True)

    stock_imports, stock_exports = analyze_abi.build_global_versions(stock_modules)
    stock_export_crcs = {}
    for name, providers in stock_exports.items():
        values = set(providers.values())
        if len(values) == 1:
            stock_export_crcs[name] = next(iter(values))

    manifest = []
    failures = 0
    for module in analyze_abi.REPLACED_MODULES:
        if module not in author_modules or module not in stock_modules:
            raise SystemExit(f"missing module: {module}")

        old_path = old_text_path(base_modules, module)
        if old_path is None:
            raise SystemExit(f"missing old text reference: {module}")

        old_text = analyze_abi.Elf(old_path).section_bytes(".text")
        source_path = author_modules[module]
        source = analyze_abi.Elf(source_path)
        if sha256(source.section_bytes(".text")) != sha256(old_text):
            raise SystemExit(f"source text is not old: {module}")

        data = bytearray(source.data)
        version_patches = []
        crc_patches = []

        for item in source.import_versions():
            expected = unique_import_crc(stock_imports, item["name"])
            if expected is None and item["name"] in stock_export_crcs:
                expected = stock_export_crcs[item["name"]]
            if expected is not None and expected != item["crc"]:
                if not isinstance(expected, int):
                    raise SystemExit(
                        f"non-integer import CRC expectation: {module}:{item['name']}"
                    )
                struct.pack_into(
                    "<Q",
                    data,
                    source.section("__versions")["offset"] + item["offset"],
                    expected,
                )
                version_patches.append((item["name"], item["crc"], expected))

        for name, info in sorted(source.export_crcs().items()):
            expected = unique_export_crc(stock_exports, name)
            if expected is None:
                expected = unique_import_crc(stock_imports, name)
            if expected is not None and expected != info["crc"]:
                if not isinstance(expected, int):
                    raise SystemExit(
                        f"non-integer export CRC expectation: {module}:{name}"
                    )
                struct.pack_into("<I", data, info["offset"], expected)
                crc_patches.append((name, info["crc"], expected))

        destination = os.path.join(args.output, module)
        with open(destination, "wb") as handle:
            handle.write(data)

        patched = analyze_abi.Elf(destination)
        version_map = {item["name"]: item["crc"] for item in patched.import_versions()}
        export_map = {
            name: info["crc"] for name, info in patched.export_crcs().items()
        }
        for name, _, expected in version_patches:
            if version_map.get(name) != expected:
                raise SystemExit(f"version patch verification failed: {module}:{name}")
        for name, _, expected in crc_patches:
            if export_map.get(name) != expected:
                raise SystemExit(f"crc patch verification failed: {module}:{name}")

        manifest.append(
            {
                "module": module,
                "source_sha256": sha256(bytes(source.data)),
                "patched_sha256": sha256(bytes(data)),
                "version_patches": version_patches,
                "crc_patches": crc_patches,
            }
        )

    manifest_path = os.path.join(args.output, "patch_manifest.txt")
    with open(manifest_path, "w", encoding="utf-8") as handle:
        handle.write(f"modules={len(manifest)}\n")
        handle.write(
            "version_patches="
            + str(sum(len(item["version_patches"]) for item in manifest))
            + "\n"
        )
        handle.write(
            "export_crc_patches="
            + str(sum(len(item["crc_patches"]) for item in manifest))
            + "\n"
        )
        for item in manifest:
            handle.write(
                f"\n[{item['module']}]\n"
                f"source_sha256={item['source_sha256']}\n"
                f"patched_sha256={item['patched_sha256']}\n"
            )
            for name, old, new in item["version_patches"]:
                handle.write(f"import_crc {name}: {old:#010x} -> {new:#010x}\n")
            for name, old, new in item["crc_patches"]:
                handle.write(f"export_crc {name}: {old:#010x} -> {new:#010x}\n")

    print(
        f"patched_modules={len(manifest)} "
        f"version_patches={sum(len(item['version_patches']) for item in manifest)} "
        f"export_crc_patches={sum(len(item['crc_patches']) for item in manifest)}"
    )
    print(f"manifest={manifest_path}")
    return 1 if failures else 0


if __name__ == "__main__":
    sys.exit(main())
