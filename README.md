# skk-verb-adjective-dictionary

[![CI](https://github.com/NI57721/skk-verb-adjective-dictionary/actions/workflows/ci.yml/badge.svg?branch=main&event=push)](https://github.com/NI57721/skk-verb-adjective-dictionary/actions/workflows/ci.yml)

[vim-caskk](https://github.com/NI57721/vim-caskk) 用の動詞・形容詞の SKK 辞書です。辞書は活用情報をアノテーションに持つ語幹で構成されており、[vim-caskk](https://github.com/NI57721/vim-caskk) が入力された送り仮名と組み合わせて変換します。

```text
あいいれ /相容れ;@verb-1/相いれ;@verb-1/相入れ;@verb-1/
```

## 辞書をダウンロード
https://github.com/NI57721/skk-verb-adjective-dictionary/releases/latest/download/SKK-JISYO.verb-adjective

## ビルド

Ruby 4.0 と Bundler を使います。

```sh
bundle install
bundle exec rake build
```

生成先は `build/SKK-JISYO.verb-adjective` です。辞書の文字コードは UTF-8 です。

## vim-caskk で使う

`@verb-1` や `@verb-henkaku-k` など、この辞書の活用タグに対応した [vim-caskk](https://github.com/NI57721/vim-caskk) が必要です。

## ライセンス

本リポジトリは MIT ライセンスです。

辞書の元データは、Hiroshi Manabe 氏の [japanese_verb_adj_list](https://github.com/hiroshi-manabe/japanese_verb_adj_list) に由来し、CC0 1.0 が適用されています。
