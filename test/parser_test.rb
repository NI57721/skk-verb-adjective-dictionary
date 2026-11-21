# frozen_string_literal: true

require_relative 'test_helper'
require 'tempfile'
require 'skk_verb_adjective_dictionary/tsv_parser'

class ParserTest < Minitest::Test
  Parser = SkkVerbAdjectiveDictionary::JapaneseVerbAdjList::Parser

  def test_extracts_reading_spelling_and_conjugation
    entry = Parser.parse_line("アウ\t五段・ワ行促音便\t2\t逢う\t0\n")

    assert_equal 'アウ', entry.reading
    assert_equal '五段・ワ行促音便', entry.conjugation
    assert_equal '逢う', entry.spelling
  end

  def test_reads_spelling_when_third_column_is_empty
    entry = Parser.parse_line("アイクルシイ\t形容詞・イ段\t\t愛くるしい\t1\n")

    assert_equal '愛くるしい', entry.spelling
  end

  def test_parses_a_line_without_a_trailing_newline
    entry = Parser.parse_line("アイイレル\t一段\t\t相容れる\t0")

    assert_equal '相容れる', entry.spelling
  end

  def test_parses_tsv_rows
    tsv = <<~TSV
      アイイレル\t一段\t\t相容れる\t0
      アイイレル\t一段\t\t相いれる\t1
      アイクルシイ\t形容詞・イ段\t\t愛くるしい\t1
    TSV

    entries = parse_tsv(tsv)

    assert_equal %w[相容れる 相いれる 愛くるしい], entries.map(&:spelling)
  end

  def test_parses_empty_tsv
    assert_empty parse_tsv('')
  end

  private

  def parse_tsv(contents)
    Tempfile.create(['dictionary', '.tsv'], encoding: Encoding::UTF_8) do |file|
      file.write(contents)
      file.flush
      Parser.parse_tsv(file.path)
    end
  end
end
