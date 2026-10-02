# vale-styles

Joe Karlsson's [Vale](https://vale.sh) styles, shared by every place he writes.

| Style | What it checks | Used by |
|---|---|---|
| `JoeKarlsson` | Base voice: banned words (incl. "honestly"), AI filler, banned openings, filler words, em dashes, abstract reveals ("the key is"), vague attribution ("most teams"), internal research framing | everything |
| `JoeVideo` | Video-script habits: "hey guys", "in today's video", runtime promises, video filler | video scripts only |

Vocabularies in `styles/config/vocabularies/`: `Letterboxd` (film reviews), `Social` (tech names for social posts).

## Layers

Each place picks its layers in its own `.vale.ini`. A local section **replaces** the
global styles for matching files, so always list `JoeKarlsson` first:

```ini
[*.md]
BasedOnStyles = JoeKarlsson, JoeVideo   # e.g. a video-scripts folder
```

Work-only rules (the `CData` style) live in the private `cdata-skills` repo, not here.

## Using it

- **In a repo / CI:** add the package and run `vale sync`:
  ```ini
  Packages = https://github.com/JoeKarlsson/vale-styles/releases/latest/download/vale-styles.zip
  ```
- **On Joe's Macs:** chezmoi symlinks `styles/*` into Vale's global styles folder
  (`~/Library/Application Support/vale/styles`), so local edits apply immediately.
  When the same style exists globally and in a repo's synced copy, the global copy wins rule by rule.

## Changing a rule

1. Edit the `.yml`, add a line to `tests/fixtures/bad.md` and `tests/expected.txt` for a new rule.
2. `tests/run.sh`
3. Commit, then `scripts/release.sh vX.Y.Z` so CI picks it up.
