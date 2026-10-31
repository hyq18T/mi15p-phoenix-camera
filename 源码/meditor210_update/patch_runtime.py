"""以新版实际 API 修正 donor 残留接口，避免旧类名及构造器。"""

import argparse
import re
from pathlib import Path


RUNTIME = "Lcom/prometheus/camera/meditor210/MEditor210Runtime;"


def replace_method(tree, filename, signature, body):
    paths = list(tree.rglob(filename))
    if len(paths) != 1:
        raise ValueError(f"源码定位不唯一：{filename}")
    path = paths[0]
    text = path.read_text(encoding="utf-8")
    pattern = r"(\.method[^\n]* " + re.escape(signature) + r"\n).*?\.end method"
    updated, count = re.subn(pattern, lambda match: match[1] + body + "\n.end method", text, flags=re.DOTALL)
    if count != 1:
        raise ValueError(f"方法定位不唯一：{filename} {signature}")
    path.write_text(updated, encoding="utf-8")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--tree", type=Path, required=True)
    args = parser.parse_args()
    replace_method(args.tree, "GalleryV24043Bridge.smali",
        "tryInstallStableFilterHook(Ljava/lang/ClassLoader;Lcom/prometheus/camera/rev/ContentRegistry;)Z",
        "    .locals 1\n\n    invoke-static {p0, p1}, " + RUNTIME + "->installFilters(Ljava/lang/ClassLoader;Ljava/lang/Object;)Z\n\n    move-result v0\n\n    return v0")
    replace_method(args.tree, "MediaEditorWatermarkBridge.smali",
        "tryInstallStableWatermarkHooks(Ljava/lang/ClassLoader;)Z",
        "    .locals 1\n\n    invoke-static {p0}, " + RUNTIME + "->installWatermarks(Ljava/lang/ClassLoader;)Z\n\n    move-result v0\n\n    return v0")
    replace_method(args.tree, "MediaEditorWatermarkBridge$30.smali",
        "afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V",
        "    .locals 3\n\n    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->getResult()Ljava/lang/Object;\n    move-result-object v0\n    iget-object v1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;\n    const/4 v2, 0x0\n    aget-object v1, v1, v2\n    invoke-static {v0, v1}, " + RUNTIME + "->providerResult(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;\n    move-result-object v0\n    invoke-virtual {p1, v0}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->setResult(Ljava/lang/Object;)V\n    return-void")
    replace_method(args.tree, "M3EntryPoint.smali", "installMediaEditorLegendGate(Ljava/lang/ClassLoader;)V",
        "    .locals 0\n\n    invoke-static {p0}, " + RUNTIME + "->installLegend(Ljava/lang/ClassLoader;)V\n\n    return-void")
    # donor 的 installProbeHooks 引用了缺失的诊断方法。补为现有 note 入口，
    # 即使宿主版本不匹配而走后备路径，也不会产生内部 NoSuchMethodError。
    probe = next(args.tree.rglob("MeProbe.smali"))
    text = probe.read_text(encoding="utf-8")
    if " dumpRegistry(Ljava/lang/String;)V" not in text:
        text += "\n.method public static dumpRegistry(Ljava/lang/String;)V\n    .locals 0\n    invoke-static {p0}, Lcom/prometheus/camera/rev/MeProbe;->note(Ljava/lang/String;)V\n    return-void\n.end method\n"
        probe.write_text(text, encoding="utf-8")
    print("RUNTIME_API_PATCH=PASS")


if __name__ == "__main__":
    main()
