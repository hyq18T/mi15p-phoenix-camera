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


def scan(root):
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


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("baseline")
    parser.add_argument("build")
    parser.add_argument("verify")
    args = parser.parse_args()

    baseline = scan(args.baseline)
    build = scan(args.build)
    verify = scan(args.verify)

    if build != verify:
        raise SystemExit("ERROR: EROFS extracted tree differs from build tree")

    expected = {f"lib/modules/{name}" for name in analyze_abi.REPLACED_MODULES}
    changed = {
        path
        for path in sorted(set(baseline) | set(build))
        if baseline.get(path) != build.get(path)
    }
    if changed != expected:
        raise SystemExit(
            "ERROR: unexpected changed files: "
            f"missing={sorted(expected - changed)} "
            f"extra={sorted(changed - expected)}"
        )

    print(
        f"files={len(build)} erofs_tree_verified=true "
        f"changed_modules={len(changed)} only_expected=true"
    )
    return 0


if __name__ == "__main__":
    sys.exit(main())
