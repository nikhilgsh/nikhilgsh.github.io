#!/usr/bin/env bash
#
# Copy the built PoLoRA post into polora/ and add a link back to this site.
#
#   bin/sync-polora.sh [path-to-polora_website]
#
# The post is written and built in its own repo, which several people share,
# and it may be published under any of its authors' sites. A "back to this
# site" link therefore does not belong in that repo's src/header.html, which
# would assert one author's site as the post's parent everywhere it is served.
# It belongs here, in the step that adapts the built page for this deployment.
#
# Re-running is safe: each run starts from a fresh copy of the built page.

set -eo pipefail

SITE_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE_REPO="${1:-$HOME/polora_website}"
DEST="$SITE_ROOT/polora"

if [ ! -f "$SOURCE_REPO/index.html" ]; then
  echo "no built index.html under $SOURCE_REPO" >&2
  exit 1
fi

# Refuse a stale build rather than publishing one: index.html is generated from
# src/, and build.py --check exits non-zero when the two disagree.
python3 "$SOURCE_REPO/build.py" --check >/dev/null

mkdir -p "$DEST/assets"
cp "$SOURCE_REPO/index.html" "$DEST/index.html"
cp "$SOURCE_REPO"/assets/*.svg "$DEST/assets/"

python3 - "$DEST/index.html" <<'PY'
import sys

path = sys.argv[1]
html = open(path, encoding="utf-8").read()

# Top left, ahead of the wordmark: that is where a reader looks for the way out
# of a page, and it keeps the link clear of .toplinks, whose items are dropped
# below 560px so only "Code" survives.
WORDMARK = '<a class="wordmark" href="#top"'
LINK = '<a href="/" class="back-home">← Nikhil Ghosh</a>\n      '

# .topbar is space-between with two children, so a third would centre the
# wordmark. Pack the pair to the left and push the nav right instead.
STYLE = """<style>
      .topbar { justify-content: flex-start; }
      .topbar .toplinks { margin-left: auto; }
      .back-home { font-size: 0.86rem; font-weight: 700; white-space: nowrap; }
    </style>
  """

for name, anchor, insert in (
    ("back-link", WORDMARK, LINK + WORDMARK),
    ("style block", "</head>", STYLE + "</head>"),
):
    if html.count(anchor) != 1:
        sys.exit(f"expected exactly one {anchor!r} in {path}, found {html.count(anchor)}")
    html = html.replace(anchor, insert, 1)
    print(f"{name} inserted")

open(path, "w", encoding="utf-8").write(html)
PY

echo "synced $SOURCE_REPO -> $DEST"
