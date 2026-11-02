#!/usr/bin/env python3
import argparse
import hashlib
import os
import struct
import sys


SHN_UNDEF = 0
SHN_ABS = 0xFFF1
SHT_SYMTAB = 2
SHT_NOBITS = 8

REPLACED_MODULES = [
    "bq27z561.ko",
    "charger_partition.ko",
    "mca_basic_wireless.ko",
    "mca_bmd.ko",
    "mca_buckchg_jeita.ko",
    "mca_business_battery_comp.ko",
    "mca_business_charger_comp.ko",
    "mca_charge_mievent.ko",
    "mca_charger_thermal.ko",
    "mca_connector_antiburn.ko",
    "mca_event.ko",
    "mca_hwid.ko",
    "mca_pd_auth.ko",
    "mca_platform_buckchg_class.ko",
    "mca_platform_cp_class.ko",
    "mca_platform_fg_ic_ops.ko",
    "mca_protocol_pd_class.ko",
    "mca_qcom_smem.ko",
    "mca_qcom_subpmic_proxy.ko",
    "mca_quick_wireless.ko",
    "mca_smart_charge.ko",
    "mca_strategy_buckchg.ko",
    "mca_strategy_class.ko",
    "mca_strategy_fg_class.ko",
    "mca_strategy_fg_comp.ko",
    "mca_strategy_quickchg.ko",
    "mca_wireless_revchg.ko",
    "sc8581_sy6541.ko",
]


class Elf:
    def __init__(self, path):
        self.path = path
        with open(path, "rb") as handle:
            self.data = bytearray(handle.read())
        if self.data[:4] != b"\x7fELF":
            raise ValueError(f"not ELF: {path}")
        if self.data[4] != 2 or self.data[5] != 1:
            raise ValueError(f"only ELF64 little-endian is supported: {path}")

        self.section_offset = struct.unpack_from("<Q", self.data, 0x28)[0]
        self.section_entry_size = struct.unpack_from("<H", self.data, 0x3A)[0]
        self.section_count = struct.unpack_from("<H", self.data, 0x3C)[0]
        self.section_names_index = struct.unpack_from("<H", self.data, 0x3E)[0]
        self.sections = []

        for index in range(self.section_count):
            offset = self.section_offset + index * self.section_entry_size
            values = struct.unpack_from("<IIQQQQIIQQ", self.data, offset)
            self.sections.append(
                {
                    "index": index,
                    "name_offset": values[0],
                    "type": values[1],
                    "flags": values[2],
                    "address": values[3],
                    "offset": values[4],
                    "size": values[5],
                    "link": values[6],
                    "info": values[7],
                    "alignment": values[8],
                    "entry_size": values[9],
                }
            )

        names = self.sections[self.section_names_index]
        names_data = bytes(
            self.data[names["offset"] : names["offset"] + names["size"]]
        )
        for section in self.sections:
            start = section["name_offset"]
            section["name"] = names_data[start:].split(b"\0", 1)[0].decode("utf-8")
        self.by_name = {section["name"]: section for section in self.sections}

    def section(self, name):
        return self.by_name.get(name)

    def section_bytes(self, name):
        section = self.section(name)
        if section is None or section["type"] == SHT_NOBITS:
            return b""
        start = section["offset"]
        return bytes(self.data[start : start + section["size"]])

    def strings(self, string_section_index):
        section = self.sections[string_section_index]
        return bytes(
            self.data[section["offset"] : section["offset"] + section["size"]]
        )

    def symbols(self):
        result = []
        for section in self.sections:
            if section["type"] != SHT_SYMTAB:
                continue
            strings = self.strings(section["link"])
            entry_size = section["entry_size"] or 24
            count = section["size"] // entry_size
            for index in range(count):
                offset = section["offset"] + index * entry_size
                values = struct.unpack_from("<IBBHQQ", self.data, offset)
                name_offset = values[0]
                name = strings[name_offset:].split(b"\0", 1)[0].decode(
                    "utf-8", errors="replace"
                )
                result.append(
                    {
                        "index_on_section_entry": index,
                        "name": name,
                        "info": values[1],
                        "other": values[2],
                        "section_index": values[3],
                        "value": values[4],
                        "size": values[5],
                    }
                )
        return result

    def imports(self):
        return {
            symbol["name"]
            for symbol in self.symbols()
            if symbol["section_index"] == SHN_UNDEF
            and symbol["name"]
            and not symbol["name"].startswith("_note_")
        }

    def export_crcs(self):
        result = {}
        symbol_sections = {}
        for symbol in self.symbols():
            if (
                symbol["name"].startswith("__crc_")
                and symbol["section_index"] not in (SHN_UNDEF, SHN_ABS)
            ):
                section = self.sections[symbol["section_index"]]
                if section["type"] == SHT_NOBITS:
                    continue
                offset = section["offset"] + symbol["value"]
                crc = struct.unpack_from("<I", self.data, offset)[0]
                result[symbol["name"][6:]] = {
                    "crc": crc,
                    "section": section["name"],
                    "offset": offset,
                }
                symbol_sections[symbol["name"][6:]] = section["name"]
        return result

    def import_versions(self):
        raw = self.section_bytes("__versions")
        result = []
        for offset in range(0, len(raw) - 63, 64):
            crc = struct.unpack_from("<Q", raw, offset)[0]
            name = raw[offset + 8 : offset + 64].split(b"\0", 1)[0].decode(
                "utf-8", errors="replace"
            )
            if name:
                result.append({"offset": offset, "crc": crc, "name": name})
        return result

    def modinfo(self):
        raw = self.section_bytes(".modinfo")
        result = {}
        for item in raw.split(b"\0"):
            if b"=" not in item:
                continue
            key, value = item.decode("utf-8", errors="replace").split("=", 1)
            if key == "alias":
                result.setdefault(key, []).append(value)
            else:
                result[key] = value
        return result


def module_paths(root):
    module_dir = os.path.join(root, "lib", "modules")
    result = {}
    for name in sorted(os.listdir(module_dir)):
        if name.endswith(".ko"):
            result[name] = os.path.join(module_dir, name)
    return result


def build_global_versions(modules):
    imports = {}
    exports = {}
    for module, path in modules.items():
        elf = Elf(path)
        for item in elf.import_versions():
            imports.setdefault(item["name"], {}).setdefault(item["crc"], []).append(module)
        for name, info in elf.export_crcs().items():
            exports.setdefault(name, {})[module] = info["crc"]
    return imports, exports


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("base")
    parser.add_argument("author16")
    parser.add_argument("stock19")
    args = parser.parse_args()

    base_modules = module_paths(args.base)
    author_modules = module_paths(args.author16)
    stock_modules = module_paths(args.stock19)
    stock_imports, stock_exports = build_global_versions(stock_modules)
    stock_importers = {}
    for module, path in stock_modules.items():
        elf = Elf(path)
        for name in elf.imports():
            stock_importers.setdefault(name, set()).add(module)
    stock_export_crcs = {}
    for name, providers in stock_exports.items():
        values = set(providers.values())
        if len(values) == 1:
            stock_export_crcs[name] = next(iter(values))

    print(f"base_modules={len(base_modules)}")
    print(f"author16_modules={len(author_modules)}")
    print(f"stock19_modules={len(stock_modules)}")
    print(f"replacement_modules={len(REPLACED_MODULES)}")

    failures = 0
    total_version_patches = 0
    total_crc_patches = 0
    total_vermagic_patches = 0
    replacement_set = set(REPLACED_MODULES)

    print("\n[module analysis]")
    for module in REPLACED_MODULES:
        if module not in author_modules:
            print(f"FAIL {module}: absent from author16")
            failures += 1
            continue
        if module not in stock_modules:
            print(f"FAIL {module}: absent from stock19")
            failures += 1
            continue

        author = Elf(author_modules[module])
        stock = Elf(stock_modules[module])
        old_path = base_modules.get(module)
        old_text_hash = None
        if old_path:
            old_text_hash = hashlib.sha256(Elf(old_path).section_bytes(".text")).hexdigest()
        author_text_hash = hashlib.sha256(author.section_bytes(".text")).hexdigest()
        author_info = author.modinfo()
        stock_info = stock.modinfo()
        author_exports = author.export_crcs()
        stock_exports_this = stock.export_crcs()
        author_imports = author.imports()
        stock_imports_this = stock.imports()
        missing_imports = sorted(
            name
            for name in stock_imports_this - author_imports
            if name not in author_exports
        )
        extra_imports = sorted(
            name
            for name in author_imports - stock_imports_this
            if name not in stock_exports
        )
        removed_exports = sorted(
            name for name in stock_exports_this if name not in author_exports
        )
        removed_export_consumers = []
        for name in removed_exports:
            consumers = stock_importers.get(name, set()) - replacement_set
            if consumers:
                removed_export_consumers.append((name, sorted(consumers)))

        version_patches = []
        for item in author.import_versions():
            candidates = stock_imports.get(item["name"], {})
            if len(candidates) == 1:
                expected = next(iter(candidates))
                if expected != item["crc"]:
                    version_patches.append((item["name"], item["crc"], expected))
            elif len(candidates) > 1:
                print(
                    f"FAIL {module}: ambiguous CRC for {item['name']}: "
                    + ", ".join(f"{value:#010x}" for value in sorted(candidates))
                )
                failures += 1
            elif item["name"] in stock_export_crcs:
                expected = stock_export_crcs[item["name"]]
                if expected != item["crc"]:
                    version_patches.append((item["name"], item["crc"], expected))

        crc_patches = []
        for name, export_info in sorted(author_exports.items()):
            crc = export_info["crc"]
            expected_values = stock_exports.get(name, {})
            if len(expected_values) == 1:
                expected = next(iter(expected_values.values()))
                provider = next(iter(expected_values.keys()))
                if expected != crc:
                    crc_patches.append((name, crc, expected, provider))
            elif len(expected_values) > 1:
                unique = set(expected_values.values())
                if len(unique) == 1:
                    expected = next(iter(unique))
                    if expected != crc:
                        crc_patches.append(
                            (
                                name,
                                crc,
                                expected,
                                ",".join(sorted(expected_values.keys())),
                            )
                        )
                else:
                    print(
                        f"FAIL {module}: ambiguous exported CRC for {name}: "
                        + ", ".join(
                            f"{key}={value:#010x}"
                            for key, value in sorted(expected_values.items())
                        )
                    )
                    failures += 1
            elif stock_exports_this.get(name) is not None:
                expected = stock_exports_this[name]["crc"]
                if expected != crc:
                    crc_patches.append((name, crc, expected, module))

        missing_export_consumers = []
        for name, export_info in sorted(author_exports.items()):
            crc = export_info["crc"]
            consumers = stock_importers.get(name, set()) - replacement_set
            if not consumers:
                continue
            expected_values = stock_imports.get(name, {})
            if len(expected_values) != 1:
                print(
                    f"FAIL {module}: consumers of exported {name} have "
                    f"{len(expected_values)} CRC values"
                )
                failures += 1
                continue
            expected = next(iter(expected_values))
            if crc != expected:
                crc_patches.append((name, crc, expected, ",".join(sorted(consumers))))
            missing_export_consumers.append((name, sorted(consumers)))

        changed_consumers = []
        for stock_module, stock_path in stock_modules.items():
            if stock_module in replacement_set:
                continue
            stock_elf = Elf(stock_path)
            shared = set(stock_elf.imports()) & set(author_exports)
            if shared:
                changed_consumers.append((stock_module, sorted(shared)))

        vermagic_patch = author_info.get("vermagic") != stock_info.get("vermagic")
        depends_equal = author_info.get("depends") == stock_info.get("depends")
        total_version_patches += len(version_patches)
        total_crc_patches += len(crc_patches)
        total_vermagic_patches += int(vermagic_patch)
        if removed_export_consumers:
            failures += len(removed_export_consumers)

        print(
            f"{module}: imports={len(author_imports)} "
            f"exports={len(author_exports)} version_patches={len(version_patches)} "
            f"export_crc_patches={len(crc_patches)} "
            f"missing_vs_stock19={len(missing_imports)} "
            f"extra_vs_stock19={len(extra_imports)} "
            f"removed_exports={len(removed_exports)} "
            f"text_equals_old={author_text_hash == old_text_hash if old_text_hash else 'old-missing'} "
            f"depends_equal={depends_equal} vermagic_patch={vermagic_patch}"
        )
        if missing_imports:
            print("  stock19 imports not imported by old: " + ", ".join(missing_imports))
        if extra_imports:
            print("  old imports not represented in stock19 import set: " + ", ".join(extra_imports))
        if version_patches:
            for name, old_crc, new_crc in version_patches:
                print(
                    f"  version {name}: {old_crc:#010x} -> {new_crc:#010x}"
                )
        if crc_patches:
            for name, old_crc, new_crc, provider in crc_patches:
                print(
                    f"  export {name}: {old_crc:#010x} -> {new_crc:#010x} "
                    f"(reference={provider})"
                )
        if removed_export_consumers:
            for name, consumers in removed_export_consumers:
                print(
                    f"  FAIL removed export {name} is used by non-replaced "
                    + ", ".join(consumers)
                )
        if changed_consumers:
            print(
                "  non-replaced consumers: "
                + ", ".join(
                    f"{consumer}({','.join(names)})"
                    for consumer, names in changed_consumers
                )
            )

    print("\n[summary]")
    print(f"version_crc_patches={total_version_patches}")
    print(f"export_crc_patches={total_crc_patches}")
    print(f"vermagic_patches={total_vermagic_patches}")
    print(f"failures={failures}")
    return 1 if failures else 0


if __name__ == "__main__":
    sys.exit(main())
