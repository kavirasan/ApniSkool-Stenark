"""Fetch 8 themed Lottie JSONs from LottieFiles into assets/animations/.

Strategy:
  1. For each target, fetch the LottieFiles category page and find the first
     animation slug whose URL slug contains a strong match for the theme.
  2. Fetch the animation detail page; extract the assets-v2 .lottie CDN URL.
  3. Download the .lottie (a zip), extract the inner animations/<id>.json,
     and save it under the canonical filename.
"""
from __future__ import annotations

import io
import json
import re
import subprocess
import sys
import zipfile
from pathlib import Path

UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36")

# (output filename, LottieFiles category page, regex to match a desirable slug)
TARGETS = [
    ("streak_fire.json",
     "https://lottiefiles.com/free-animations/fire",
     re.compile(r"/free-animation/(?:streak-fire|fire-flame|flame-animation|flame-streak)[A-Za-z0-9-]*")),
    ("success_burst.json",
     "https://lottiefiles.com/free-animations/success",
     re.compile(r"/free-animation/(?:success-(?:celebration|burst|tick|check)|success)[A-Za-z0-9-]*")),
    ("try_again.json",
     "https://lottiefiles.com/free-animations/error",
     re.compile(r"/free-animation/(?:error|cross|wrong|fail)[A-Za-z0-9-]*")),
    ("ai_orb.json",
     "https://lottiefiles.com/free-animations/ai",
     re.compile(r"/free-animation/(?:ai-|orb|chat-bot|sphere)[A-Za-z0-9-]*")),
    ("empty_inbox.json",
     "https://lottiefiles.com/free-animations/empty",
     re.compile(r"/free-animation/(?:empty|inbox|mailbox|no-)[A-Za-z0-9-]*")),
    ("search_spark.json",
     "https://lottiefiles.com/free-animations/search",
     re.compile(r"/free-animation/(?:search|magnifier|magnifying)[A-Za-z0-9-]*")),
    ("trophy.json",
     "https://lottiefiles.com/free-animations/trophy",
     re.compile(r"/free-animation/(?:trophy|winner|champion|cup)[A-Za-z0-9-]*")),
    ("confetti.json",
     "https://lottiefiles.com/free-animations/confetti",
     re.compile(r"/free-animation/(?:confetti|celebration-confetti|party)[A-Za-z0-9-]*")),
]

LOTTIE_URL_RE = re.compile(
    r"assets-v2\.lottiefiles\.com/a/[a-f0-9-]+/[A-Za-z0-9_-]+\.lottie"
)


def _curl(url: str, binary: bool = False) -> bytes:
    args = ["curl", "-sL", "--fail", "--max-time", "30", "-A", UA, url]
    res = subprocess.run(args, capture_output=True, check=True)
    return res.stdout


def fetch(url: str) -> str:
    return _curl(url).decode("utf-8", errors="ignore")


def fetch_bytes(url: str) -> bytes:
    return _curl(url, binary=True)


def find_slug(category_html: str, pattern: re.Pattern) -> str | None:
    seen = set()
    for m in re.finditer(r"/free-animation/[A-Za-z0-9-]+", category_html):
        slug = m.group(0)
        if slug in seen:
            continue
        seen.add(slug)
        if pattern.search(slug):
            return slug
    # Fallback: any slug at all from this category page.
    return next(iter(seen), None)


def find_lottie_url(detail_html: str) -> str | None:
    matches = LOTTIE_URL_RE.findall(detail_html)
    # Prefer the first match that is NOT inside the urlencoded share/embed link.
    for m in matches:
        if "%2F" not in m:
            return f"https://{m}"
    return f"https://{matches[0]}" if matches else None


def extract_json(lottie_zip: bytes) -> dict:
    with zipfile.ZipFile(io.BytesIO(lottie_zip)) as zf:
        for name in zf.namelist():
            if name.startswith("animations/") and name.endswith(".json"):
                return json.loads(zf.read(name))
    raise RuntimeError("no animations/*.json inside .lottie zip")


def main() -> int:
    out_dir = Path(__file__).resolve().parents[1] / "assets" / "animations"
    out_dir.mkdir(parents=True, exist_ok=True)
    results: list[tuple[str, str]] = []
    for filename, category_url, pattern in TARGETS:
        try:
            print(f"\n[{filename}]")
            print(f"  category: {category_url}")
            cat_html = fetch(category_url)
            slug = find_slug(cat_html, pattern)
            if not slug:
                print(f"  NO MATCH on category page")
                results.append((filename, "no-slug"))
                continue
            print(f"  slug: {slug}")
            detail_url = "https://lottiefiles.com" + slug
            detail_html = fetch(detail_url)
            lottie_url = find_lottie_url(detail_html)
            if not lottie_url:
                print(f"  no .lottie url on detail page")
                results.append((filename, "no-url"))
                continue
            print(f"  lottie: {lottie_url}")
            lottie_bytes = fetch_bytes(lottie_url)
            data = extract_json(lottie_bytes)
            assert "v" in data and "layers" in data, "not a valid lottie json"
            out_path = out_dir / filename
            out_path.write_text(json.dumps(data), encoding="utf-8")
            size_kb = out_path.stat().st_size // 1024
            print(f"  saved -> {out_path} ({size_kb} KB)")
            results.append((filename, "ok"))
        except Exception as e:
            print(f"  ERROR: {e}")
            results.append((filename, f"err:{e}"))

    print("\n=== summary ===")
    for fn, status in results:
        print(f"  {fn:<22} {status}")
    return 0 if all(s == "ok" for _, s in results) else 1


if __name__ == "__main__":
    sys.exit(main())
