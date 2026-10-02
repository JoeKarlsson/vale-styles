#!/bin/bash
# Usage: scripts/release.sh v1.0.0
# Tests, builds the package zip, and publishes it as a GitHub release. Consumers
# pull https://github.com/JoeKarlsson/vale-styles/releases/latest/download/vale-styles.zip
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
VERSION="${1:?usage: release.sh vX.Y.Z}"
"$ROOT/tests/run.sh"
"$ROOT/scripts/build.sh"
git -C "$ROOT" diff --quiet && git -C "$ROOT" diff --cached --quiet || { echo "commit first"; exit 1; }
git -C "$ROOT" push -q origin HEAD
gh release create "$VERSION" "$ROOT/dist/vale-styles.zip" --repo JoeKarlsson/vale-styles --title "$VERSION" --generate-notes
