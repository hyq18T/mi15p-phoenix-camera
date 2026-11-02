#!/usr/bin/env python3
import argparse
import hashlib
import os
import sys


IMAGE_SIZE = 88_707_072


def sha256_file(path):
    digest = hashlib.sha256()
    with open(path, "rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def read_hashes(path, base):
    result = {}
    with open(path, encoding="utf-8") as handle:
        for raw in handle:
            line = raw.strip()
            if not line or line.startswith("#"):
                continue
            digest, filename = line.split(None, 1)
            filename = filename.lstrip("*")
            result[filename] = (
                digest.lower(),
                os.path.join(base, filename),
            )
    return result


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("root", nargs="?", default=os.path.dirname(os.path.dirname(__file__)))
    args = parser.parse_args()
    root = os.path.abspath(args.root)
    failures = []

    module_dir = os.path.join(root, "modules")
    modules = sorted(
        name for name in os.listdir(module_dir) if name.endswith(".ko")
    )
    if len(modules) != 28:
        failures.append(f"KO 数量错误: {len(modules)} != 28")

    module_hashes = read_hashes(
        os.path.join(root, "modules_sha256.txt"), module_dir
    )
    for name in modules:
        item = module_hashes.get(name)
        if item is None:
            failures.append(f"模块哈希清单缺少: {name}")
            continue
        expected, path = item
        actual = sha256_file(path)
        if actual != expected:
            failures.append(f"模块哈希不匹配: {name}")

    artifact_dir = os.path.join(root, "artifacts")
    if not os.path.isdir(artifact_dir):
        artifact_dir = root
    image_hashes = read_hashes(
        os.path.join(root, "镜像SHA256.txt"), artifact_dir
    )
    for name, (expected, path) in sorted(image_hashes.items()):
        if not os.path.isfile(path):
            failures.append(f"镜像不存在: {name}")
            continue
        size = os.path.getsize(path)
        if size != IMAGE_SIZE:
            failures.append(f"镜像大小错误: {name}: {size} != {IMAGE_SIZE}")
        actual = sha256_file(path)
        if actual != expected:
            failures.append(f"镜像哈希不匹配: {name}")

    if failures:
        for failure in failures:
            print(f"FAIL {failure}")
        return 1
    print("release_verified=true images=2 modules=28 failures=0")
    return 0


if __name__ == "__main__":
    sys.exit(main())
