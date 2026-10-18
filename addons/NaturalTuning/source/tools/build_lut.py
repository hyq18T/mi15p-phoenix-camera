import json
from pathlib import Path

import numpy as np
from PIL import Image, ImageDraw


ROOT = Path(r"D:\GPT\2026-09-27_小米15Pro_Phoenix相机适配")
OUT = ROOT / "03_输出" / "NaturalTuning-15Pro-V1.4.0-20261018"
VIVID = OUT / "lut" / "15pro_vivid_gamma_57633.json"
NATURAL = ROOT / "02_数据" / "NaturalTuning_V1.4.0" / "natural_curve_18pm.json"

N = 64
SATURATION_TRIM = 0.97


def load_curve(path, key="curve"):
    data = json.loads(path.read_text(encoding="utf-8"))
    curve = np.asarray(data[key], dtype=np.float64) / 1023.0
    if len(curve) != 257:
        raise ValueError(f"{path} has {len(curve)} points, expected 257")
    return np.clip(curve, 0.0, 1.0)


def map_vivid_to_natural(rgb, vivid, natural):
    grid = np.linspace(0.0, 1.0, len(vivid))
    x = np.interp(rgb, vivid, grid)
    return np.interp(x, grid, natural)


def trim_saturation(rgb, amount):
    luma = 0.2126 * rgb[..., 0] + 0.7152 * rgb[..., 1] + 0.0722 * rgb[..., 2]
    return np.clip(luma[..., None] + (rgb - luma[..., None]) * amount, 0.0, 1.0)


def build_cube(vivid, natural):
    coords = np.linspace(0.0, 1.0, N, dtype=np.float64)
    r, g, b = np.meshgrid(coords, coords, coords, indexing="ij")
    rgb = np.stack([r, g, b], axis=-1)
    mapped = map_vivid_to_natural(rgb, vivid, natural)
    mapped = trim_saturation(mapped, SATURATION_TRIM)
    return np.clip(np.rint(mapped * 255.0), 0, 255).astype(np.uint8)


def write_png(cube, path):
    # Camera CubeLutEffect expects an 8x8 atlas of 64x64 slices (512x512 RGB).
    image = np.zeros((512, 512, 3), dtype=np.uint8)
    for slice_index in range(N):
        tile_row, tile_col = divmod(slice_index, 8)
        y0 = tile_row * N
        x0 = tile_col * N
        # Camera CubeLutEffect atlas: x=R, y=G, tile index=B.
        image[y0:y0 + N, x0:x0 + N, :] = np.transpose(
            cube[:, :, slice_index, :], (1, 0, 2))
    Image.fromarray(image, "RGB").save(path, optimize=True)


def write_cube(vivid, natural, path):
    coords = np.linspace(0.0, 1.0, 33)
    with path.open("w", encoding="ascii", newline="\n") as handle:
        handle.write('TITLE "Phoenix NaturalTuning 15Pro 18PM gamma"\n')
        handle.write("LUT_3D_SIZE 33\n")
        handle.write("DOMAIN_MIN 0.0 0.0 0.0\nDOMAIN_MAX 1.0 1.0 1.0\n")
        for b in coords:
            for g in coords:
                for r in coords:
                    rgb = np.array([r, g, b], dtype=np.float64)
                    value = map_vivid_to_natural(rgb, vivid, natural)
                    value = trim_saturation(value, SATURATION_TRIM)
                    handle.write("%.6f %.6f %.6f\n" % tuple(value))


def apply_cube(image, cube):
    src = np.asarray(image, dtype=np.float64) / 255.0
    pos = src * (N - 1)
    i0 = np.floor(pos).astype(np.int32)
    i1 = np.minimum(i0 + 1, N - 1)
    frac = pos - i0
    r0, g0, b0 = i0[..., 0], i0[..., 1], i0[..., 2]
    r1, g1, b1 = i1[..., 0], i1[..., 1], i1[..., 2]
    fr, fg, fb = frac[..., 0], frac[..., 1], frac[..., 2]

    def at(r, g, b):
        return cube[r, g, b].astype(np.float64)

    c000, c100 = at(r0, g0, b0), at(r1, g0, b0)
    c010, c110 = at(r0, g1, b0), at(r1, g1, b0)
    c001, c101 = at(r0, g0, b1), at(r1, g0, b1)
    c011, c111 = at(r0, g1, b1), at(r1, g1, b1)
    c00 = c000 * (1 - fr)[..., None] + c100 * fr[..., None]
    c10 = c010 * (1 - fr)[..., None] + c110 * fr[..., None]
    c01 = c001 * (1 - fr)[..., None] + c101 * fr[..., None]
    c11 = c011 * (1 - fr)[..., None] + c111 * fr[..., None]
    c0 = c00 * (1 - fg)[..., None] + c10 * fg[..., None]
    c1 = c01 * (1 - fg)[..., None] + c11 * fg[..., None]
    result = c0 * (1 - fb)[..., None] + c1 * fb[..., None]
    return Image.fromarray(np.clip(np.rint(result), 0, 255).astype(np.uint8), "RGB")


def make_validation_image(cube):
    image = Image.new("RGB", (960, 540), (18, 18, 18))
    draw = ImageDraw.Draw(image)
    draw.text((24, 16), "Left: input   Right: 15 Pro vivid -> 18PM natural", fill=(235, 235, 235))

    for i in range(32):
        value = round(i * 255 / 31)
        x = 24 + i * 14
        draw.rectangle([x, 48, x + 13, 110], fill=(value, value, value))

    patches = [
        (220, 30, 30), (30, 180, 60), (30, 70, 220), (230, 190, 30),
        (30, 190, 200), (190, 30, 190), (222, 160, 128), (128, 96, 72),
    ]
    for i, color in enumerate(patches):
        x = 24 + i * 58
        draw.rectangle([x, 132, x + 52, 192], fill=color)

    source = image.crop((0, 0, 480, 540))
    target = Image.new("RGB", (480, 540), (18, 18, 18))
    target.paste(apply_cube(source, cube), (0, 0))
    canvas = Image.new("RGB", (960, 540), (18, 18, 18))
    canvas.paste(source, (0, 0))
    canvas.paste(target, (480, 0))
    draw = ImageDraw.Draw(canvas)
    draw.line([(480, 0), (480, 540)], fill=(80, 80, 80), width=1)
    return canvas


def main():
    vivid = load_curve(VIVID)
    natural = load_curve(NATURAL)
    cube = build_cube(vivid, natural)

    lut_dir = OUT / "lut"
    preview_dir = OUT / "preview"
    lut_dir.mkdir(parents=True, exist_ok=True)
    preview_dir.mkdir(parents=True, exist_ok=True)

    png_path = lut_dir / "lut_cvstyle_natural.png"
    cube_path = lut_dir / "natural_18pm_33.cube"
    preview_path = preview_dir / "lut_validation.png"
    write_png(cube, png_path)
    write_cube(vivid, natural, cube_path)
    make_validation_image(cube).save(preview_path, optimize=True)

    grid = np.linspace(0.0, 1.0, 257)
    probe = {}
    for value in (0.10, 0.25, 0.50, 0.75, 0.90):
        rendered = float(np.interp(value, vivid, grid))
        output = float(np.interp(rendered, grid, natural))
        probe[f"in_{value:.2f}"] = {"vivid_out": round(rendered, 5), "natural_out": round(output, 5)}

    meta = {
        "name": "PhoenixAddon-NaturalTuning-15Pro",
        "mapping": "out = 18PM_natural(15Pro_vivid_inverse(input)); luma-preserving saturation trim",
        "lut_size": N,
        "lut_png": str(png_path),
        "vivid_curve": {"source": str(VIVID), "region": "gamma152_ipe_v2", "sid": 57633},
        "natural_curve": {"source": str(NATURAL), "points": 257},
        "vivid_probe": {f"x{x}": round(float(np.interp(x, grid, vivid)), 6) for x in (0.0625, 0.125, 0.25, 0.5, 0.75)},
        "natural_probe": {f"x{x}": round(float(np.interp(x, grid, natural)), 6) for x in (0.0625, 0.125, 0.25, 0.5, 0.75)},
        "saturation_trim": SATURATION_TRIM,
        "probe": probe,
    }
    (lut_dir / "lut_meta.json").write_text(json.dumps(meta, ensure_ascii=False, indent=2), encoding="utf-8")
    print(json.dumps(meta, ensure_ascii=False, indent=2))
    print("png", png_path.stat().st_size, "cube", cube_path.stat().st_size, "preview", preview_path.stat().st_size)


if __name__ == "__main__":
    main()
