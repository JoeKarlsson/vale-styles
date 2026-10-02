#!/bin/bash
# Build dist/vale-styles.zip in Vale package layout: vale-styles/styles/<Style>/...
# No .vale.ini goes in the zip on purpose: a package's .vale.ini is merged into
# every consumer's config, and each consumer picks its own layers.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
mkdir -p "$TMP/vale-styles" "$ROOT/dist"
/bin/cp -R "$ROOT/styles" "$TMP/vale-styles/styles"
rm -f "$ROOT/dist/vale-styles.zip"
(cd "$TMP" && /usr/bin/zip -qr "$ROOT/dist/vale-styles.zip" vale-styles -x '*.DS_Store')
echo "built $ROOT/dist/vale-styles.zip"
