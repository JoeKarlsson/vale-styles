#!/bin/bash
# Lint the fixtures with only this repo's styles (no global config) and check
# that every expected rule fires on bad.md and nothing fires on good.md.
set -uo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TMP="$(mktemp -d)"; trap 'rm -rf "$TMP"' EXIT
printf 'StylesPath = %s/styles\nMinAlertLevel = suggestion\n\n[*.md]\nBasedOnStyles = JoeKarlsson, JoeVideo\n' "$ROOT" > "$TMP/.vale.ini"
OUT="$(vale --no-global --config "$TMP/.vale.ini" --output line "$ROOT/tests/fixtures/bad.md" "$ROOT/tests/fixtures/good.md")"
fail=0
while read -r file rule; do
  if ! grep -q "$file:.*:$rule:" <<<"$OUT"; then echo "MISSING: $rule on $file"; fail=1; fi
done < "$ROOT/tests/expected.txt"
if grep -q "good.md:" <<<"$OUT"; then echo "UNEXPECTED hits on good.md:"; grep "good.md:" <<<"$OUT"; fail=1; fi
[ $fail = 0 ] && echo "ok: $(grep -c . "$ROOT/tests/expected.txt") expected rules fired, good.md clean"
exit $fail
