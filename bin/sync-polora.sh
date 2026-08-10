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

BACK_LINK='<a href="/" class="back-home">← Nikhil Ghosh</a>'
# First child of the topbar nav, so the link sits at the start of the row.
ANCHOR='<nav class="toplinks" aria-label="Primary">'

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

python3 - "$DEST/index.html" "$ANCHOR" "$BACK_LINK" <<'PY'
import sys

path, anchor, link = sys.argv[1], sys.argv[2], sys.argv[3]
html = open(path, encoding="utf-8").read()

if html.count(anchor) != 1:
    sys.exit(f"expected exactly one {anchor!r} in {path}, found {html.count(anchor)}")

# Match the indentation of the nav's existing children so the output stays
# readable when someone views source.
html = html.replace(anchor, anchor + "\n        " + link, 1)
open(path, "w", encoding="utf-8").write(html)
print("back-link inserted")
PY

echo "synced $SOURCE_REPO -> $DEST"
