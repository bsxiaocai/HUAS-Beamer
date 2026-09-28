"""Remove white from the supplied red badge without redrawing its pixels.

Copyright (C) 2026 bsxiaocai
SPDX-License-Identifier: LPPL-1.3c
Requires Pillow; run from any directory. See LICENSE and NOTICE.md.
"""
from pathlib import Path

from PIL import Image


def extract(source: Path, destination: Path) -> None:
    if destination.exists():
        raise FileExistsError(f"Refusing to overwrite {destination}")
    image = Image.open(source).convert("RGB")
    # The source is red ink on white. Low chroma JPEG noise is discarded;
    # pale edge pixels fade smoothly, while solid red pixels stay opaque.
    # RGB values, geometry and resolution are retained exactly.
    alpha = Image.new("L", image.size)
    pixels = image.tobytes()
    alpha.putdata([
        round(255 * min(1, max(0, (red - min(green, blue) - 6) / 114)) ** 1.5)
        for red, green, blue in zip(pixels[0::3], pixels[1::3], pixels[2::3])
    ])
    image.putalpha(alpha)
    destination.parent.mkdir(parents=True, exist_ok=True)
    image.save(destination)
    print(f"Saved {destination} ({image.width} x {image.height}, RGBA)")


if __name__ == "__main__":
    root = Path(__file__).resolve().parent.parent
    extract(
        root / "assets/research/HUAS-School_badge-white_background.jpg",
        root / "assets/research/HUAS-School_badge-transparent.png",
    )
