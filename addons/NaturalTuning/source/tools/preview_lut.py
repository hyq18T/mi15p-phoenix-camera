import json
from pathlib import Path

import numpy as np
from PIL import Image, ImageDraw

ROOT = Path(__file__).resolve().parents[1]
LUT_PNG = ROOT / "lut" / "lut_cvstyle_natural.png"
OUT = ROOT / "preview" / "preview_color_patches.png"
N = 64


def load_lut() -> np.ndarray:
    image = np.asarray(Image.open(LUT_PNG).convert("RGB"), dtype=np.float64) / 255.0
    table = np.zeros((N, N, N, 3), dtype=np.float64)
    for blue in range(N):
        tile_row, tile_col = divmod(blue, 8)
        for red in range(N):
            x = tile_col * N + red
            y = tile_row * N
            table[red, :, blue, :] = image[y:y + N, x, :]
    return table


def apply_lut(table: np.ndarray, rgb: np.ndarray) -> np.ndarray:
    scaled = np.clip(rgb, 0.0, 1.0) * (N - 1)
    low = np.floor(scaled).astype(np.int32)
    high = np.minimum(low + 1, N - 1)
    frac = scaled - low
    result = np.zeros_like(rgb, dtype=np.float64)
    for dr in (0, 1):
        wr = frac[..., 0] if dr else 1.0 - frac[..., 0]
        for dg in (0, 1):
            wg = frac[..., 1] if dg else 1.0 - frac[..., 1]
            for db in (0, 1):
                wb = frac[..., 2] if db else 1.0 - frac[..., 2]
                r = high[..., 0] if dr else low[..., 0]
                g = high[..., 1] if dg else low[..., 1]
                b = high[..., 2] if db else low[..., 2]
                result += table[r, g, b] * (wr * wg * wb)[..., None]
    return np.clip(result, 0.0, 1.0)


def main() -> None:
    table = load_lut()
    patches = [
        ("skin-light", (0.86, 0.70, 0.60)),
        ("skin-tan", (0.62, 0.44, 0.33)),
        ("sky", (0.32, 0.56, 0.86)),
        ("foliage", (0.24, 0.46, 0.20)),
        ("red", (0.78, 0.16, 0.15)),
        ("gray-90", (0.90, 0.90, 0.90)),
        ("gray-50", (0.50, 0.50, 0.50)),
        ("gray-10", (0.10, 0.10, 0.10)),
    ]
    original = np.array([p[1] for p in patches], dtype=np.float64)
    mapped = apply_lut(table, original)

    cell_w, cell_h = 180, 96
    canvas = Image.new("RGB", (cell_w * 2, cell_h * len(patches) + 40), (24, 24, 24))
    draw = ImageDraw.Draw(canvas)
    draw.text((12, 12), "source", fill=(235, 235, 235))
    draw.text((cell_w + 12, 12), "18PM natural LUT", fill=(235, 235, 235))

    def to_u8(rgb):
        return tuple(int(round(v * 255.0)) for v in rgb)

    for index, (name, _) in enumerate(patches):
        y = 40 + index * cell_h
        draw.rectangle([8, y + 8, cell_w - 8, y + cell_h - 8], fill=to_u8(original[index]))
        draw.rectangle(
            [cell_w + 8, y + 8, cell_w * 2 - 8, y + cell_h - 8],
            fill=to_u8(mapped[index]),
        )
        draw.text((16, y + 12), name, fill=(0, 0, 0))
        draw.text((cell_w + 16, y + 12), name, fill=(0, 0, 0))

    canvas.save(OUT, optimize=True)
    report = {
        "lut_png": str(LUT_PNG),
        "lut_size": N,
        "patches": [
            {
                "name": name,
                "source": [round(v, 6) for v in original[i].tolist()],
                "mapped": [round(v, 6) for v in mapped[i].tolist()],
            }
            for i, (name, _) in enumerate(patches)
        ],
    }
    (ROOT / "preview" / "lut_patch_report.json").write_text(
        json.dumps(report, ensure_ascii=False, indent=2), encoding="utf-8"
    )
    print(json.dumps(report, ensure_ascii=False, indent=2))


if __name__ == "__main__":
    main()
