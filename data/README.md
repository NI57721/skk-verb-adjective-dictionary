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

The [upstream dictionary workflow](../.github/workflows/upstream-dictionary.yml)
checks the TSV on upstream's `master` branch every Monday and on demand. If the
bytes differ, the failed step prints the proposed commit and checksum. Review
the upstream change, update `upstream.json`, and run `bundle exec rake` and
`bundle exec rake build` before committing the updated lock.

## Releases

Run the CI workflow manually on `main` to publish. Compared with the latest
stable release, a changed TSV checksum increments the minor version and
resets the patch version to zero. With the same TSV, a changed generated SKK
file increments the patch version. If both inputs and output match, the
workflow skips publication. A version tag pushed manually can still publish
a release.
