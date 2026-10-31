"""核对实际交付 APK、模块载荷、版本、签名和实机样张。"""

import hashlib
import json
import re
import subprocess
import zipfile
from pathlib import Path

from PIL import Image


PROJECT = Path(__file__).resolve().parents[2]
SLUG = "2026-10-30_meditor210_update"
DELIVERY = PROJECT / "04_交付" / SLUG
TESTS = PROJECT / "06_测试" / SLUG
REPOSITORY = PROJECT / "04_交付" / "git仓库-Phoenix-1.3.0-15Pro-槐蔭區2改"
BUILD_TOOLS = Path("D:/GPT/_phoenix_build/_android-sdk/build-tools/35.0.0")


def digest(path):
    with path.open("rb") as stream:
        return hashlib.file_digest(stream, "sha256").hexdigest()


def main():
    lsp = DELIVERY / "Phoenix_LSP_AllInOne-MEditor210-1.3.0-15Pro.apk"
    module = DELIVERY / "Phoenix_15Pro_Camera_M3_MEditor210_AllInOne-1.3.0.zip"
    editor = DELIVERY / "MediaEditor_2.10.43.0.8.apk"
    baseline = PROJECT / "02_数据" / SLUG / "rollback/old_allinone_lsp.apk"
    baseline_module = REPOSITORY / "成品/Phoenix_15Pro_Camera_M3_AllInOne-1.3.0.zip"
    result = {"status": "PASS", "artifacts": {}, "signatures": {}, "photos": {}}
    for path in (lsp, module, editor):
        result["artifacts"][path.name] = {"bytes": path.stat().st_size, "sha256": digest(path)}
    with zipfile.ZipFile(lsp) as current, zipfile.ZipFile(baseline) as previous:
        assert current.testzip() is None
        assert "classes15.dex" in current.namelist()
        preserved = json.loads((TESTS / "final_preserved_dex_report.json").read_text(encoding="utf-8"))
        for name, expected in preserved["preserved_dex"].items():
            assert hashlib.sha256(current.read(name)).hexdigest() == expected, name
        preserved_assets = [name for name in previous.namelist() if name.startswith("assets/") and name != "assets/xposed_init"]
        for name in preserved_assets:
            assert current.read(name) == previous.read(name), name
        entries = [line.strip() for line in current.read("assets/xposed_init").decode("utf-8").splitlines() if line.strip()]
        assert len(entries) == len(set(entries)) == 18
        assert "com.prometheus.camera.m3.M3EntryPoint" in entries
        assert "com.prometheus.camera.m3.M3Runtime" in entries
        assert "com.prometheus.camera.natural15pro.NaturalEntry" in entries
        assert "com.prometheus.camera.rev.MeditorExtrasEntry" in entries
        assert "com.ishtar.mistfix.MistFix" not in entries
        result.update({"xposed_entry_count": len(entries), "preserved_asset_count": len(preserved_assets),
                       "preserved_dex": preserved["preserved_dex"], "original_camera_m3_natural_assets_identical": True})
    with zipfile.ZipFile(module) as current, zipfile.ZipFile(baseline_module) as previous:
        assert current.testzip() is None
        modified = {"module.prop", "customize.sh", "install-self-check.sh", "Phoenix_LSP_AllInOne-1.3.0.apk"}
        for name in previous.namelist():
            if name not in modified:
                assert current.read(name) == previous.read(name), name
        for name, external in (("Phoenix_LSP_AllInOne-1.3.0.apk", lsp), ("MediaEditor_2.10.43.0.8.apk", editor)):
            with current.open(name) as stream:
                assert hashlib.file_digest(stream, "sha256").hexdigest() == digest(external)
        prop = current.read("module.prop").decode("utf-8")
        assert "id=phoenix_camera_15pro" in prop and "versionCode=2013004" in prop
        result["module_camera_and_m3_payloads_identical"] = True
    # 所有工具调用使用当前已映射到项目内的 ASCII 路径。
    mapped = {lsp: "W:/" + lsp.name, editor: "W:/" + editor.name,
              baseline: "V:/backup/old_allinone_lsp.apk",
              PROJECT / "02_数据" / SLUG / "rollback/old_mediaeditor.apk": "V:/backup/old_mediaeditor.apk"}
    for path, tool_path in mapped.items():
        output = subprocess.check_output(["java", "-Djava.io.tmpdir=V:/java_tmp", "-jar", str(BUILD_TOOLS / "lib/apksigner.jar"),
                                          "verify", "--print-certs", tool_path], text=True)
        cert = re.search(r"Signer #1 certificate SHA-256 digest: (\w+)", output)[1]
        result["signatures"][path.name] = cert
    assert result["signatures"][lsp.name] == result["signatures"][baseline.name]
    assert result["signatures"][editor.name] == result["signatures"]["old_mediaeditor.apk"]
    subprocess.run([str(BUILD_TOOLS / "zipalign.exe"), "-c", "4", "W:/" + lsp.name], check=True)
    for name, expected in ((lsp.name, 2010503), (editor.name, 210994308)):
        output = subprocess.check_output([str(BUILD_TOOLS / "aapt.exe"), "dump", "badging", "W:/" + name], text=True, encoding="utf-8", errors="replace")
        assert int(re.search(r"versionCode='(\d+)'", output)[1]) == expected
        result["artifacts"][name]["version_code"] = expected
    for pattern in ("palette_export_*.jpg", "ai_superresolution_export_*.jpg", "m3_capture_*.jpg"):
        images = list(TESTS.glob(pattern))
        assert images, pattern
        for path in images:
            with Image.open(path) as image:
                image.load()
                result["photos"][path.name] = {"dimensions": list(image.size), "bytes": path.stat().st_size,
                                              "sha256": digest(path), "decodable": True}
    result["validation_scope"] = "APK/载荷/签名校验，以及已保存的滤镜调色盘、AI超清和M3实机样张；各云端AI功能未逐项出图"
    (TESTS / "final_delivery_validation.json").write_text(json.dumps(result, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({key: value for key, value in result.items() if key not in ("preserved_dex", "signatures")}, ensure_ascii=False, indent=2))


if __name__ == "__main__":
    main()
