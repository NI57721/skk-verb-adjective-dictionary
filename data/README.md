# Source Dictionary

`japanese_verb_adj_list.tsv` comes from [japanese_verb_adj_list](https://github.com/hiroshi-manabe/japanese_verb_adj_list) by Hiroshi Manabe.

The original dataset is made available under CC0 1.0 Universal.

This dataset is not covered by the MIT license applicable to the converter's source code.

Original source: https://github.com/hiroshi-manabe/japanese_verb_adj_list

License: https://creativecommons.org/publicdomain/zero/1.0/

## Upstream updates

[`upstream.json`](upstream.json) records the upstream commit and the SHA-256 of the TSV.
Builds and tests fetch that revision with `curl` and verify the checksum.
The verified copy is cached under `build/source/` and can be reused offline.

The [CI workflow](../.github/workflows/ci.yml) checks upstream's `master` branch
every Monday. To run the same check on demand, run **CI** on `main` with
**Check upstream and release any dictionary data update** enabled.

When the TSV changes, the workflow updates the lock, runs the tests and builds
the dictionary. After those steps pass, it commits the lock to `main` as
`Update upstream dictionary to <short SHA>` and publishes a minor release
tagged at that commit. A failed test or build leaves `main` untouched.

## Releases

To publish conversion changes, run **CI** on `main` with the upstream check
unchecked. Compared with the latest stable release, a changed TSV checksum
increments the minor version and resets the patch version to zero. With the
same TSV, a changed generated SKK file increments the patch version. If both
inputs and output match, the workflow skips publication. A version tag pushed
manually can still publish a release.
