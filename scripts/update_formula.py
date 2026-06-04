#!/usr/bin/env python3
"""Bump Formula/sast.rb to the latest `sast` release on PyPI.

Reads the newest sdist URL + sha256 from https://pypi.org/pypi/sast/json and
rewrites the formula's `url`/`sha256` lines. Run after each PyPI release:

    python scripts/update_formula.py            # latest
    python scripts/update_formula.py 0.1.2      # a specific version
"""
import json
import os
import re
import sys
import urllib.request

FORMULA = os.path.join(os.path.dirname(__file__), "..", "Formula", "sast.rb")


def fetch(version: str | None):
    url = f"https://pypi.org/pypi/sast/{version}/json" if version else "https://pypi.org/pypi/sast/json"
    with urllib.request.urlopen(url, timeout=30) as r:
        data = json.load(r)
    for u in data["urls"]:
        if u["packagetype"] == "sdist":
            return data["info"]["version"], u["url"], u["digests"]["sha256"]
    raise SystemExit("no sdist found on PyPI for that version")


def main():
    version = sys.argv[1] if len(sys.argv) > 1 else None
    ver, url, sha = fetch(version)
    with open(FORMULA, encoding="utf-8") as fh:
        src = fh.read()
    src = re.sub(r'^(\s*)url\s+".*"', rf'\1url "{url}"', src, count=1, flags=re.M)
    src = re.sub(r'^(\s*)sha256\s+"[0-9a-f]*"', rf'\1sha256 "{sha}"', src, count=1, flags=re.M)
    with open(FORMULA, "w", encoding="utf-8") as fh:
        fh.write(src)
    print(f"Formula updated to sast {ver}\n  url:    {url}\n  sha256: {sha}")


if __name__ == "__main__":
    main()
