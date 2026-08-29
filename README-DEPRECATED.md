# DEPRECATED — moved to `workspaces-images`

This local clone is **deprecated as of 2026-05-02**. It tracks the
older `kasmtech/appstream-images` repository which Kasm renamed years
ago to `workspaces-images`.

## What to use instead

```sh
git clone git@github.com:goldenhelix/workspaces-images.git
cd workspaces-images
# default branch is goldenhelix-master-20260430

# After ../workspaces-core-images/build-trixie.sh has produced the core:
./build-trixie.sh                 # office-web on the trixie core
./build-varseq-trixie.sh          # local-test varseq image (needs src/varseq/varseq.tar.gz staged)
```

For the production VarSeq build (downloads from the goldenhelix
proxy), use `varseq/server/build/build.mjs` with
`--build-arg BASE_IMAGE=ghdesktop-office-web-trixie`.

See [`GOLDENHELIX.md`](https://github.com/goldenhelix/workspaces-images/blob/goldenhelix-master-20260430/GOLDENHELIX.md)
in the new repo for the full picture.

## Why this clone still exists locally

It was the development scratchpad while we ported everything over.
Safe to `rm -rf` it once you've confirmed the new fork builds cleanly.
**Do not push** anything from here — `origin` still points at the
original kasmtech remote, and goldenhelix no longer maintains a fork
at the old name.
