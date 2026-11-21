# frozen_string_literal: true

require_relative 'test_helper'
require 'skk_verb_adjective_dictionary/entry'
require 'skk_verb_adjective_dictionary/tsv_parser'

class EntryTest < Minitest::Test
  Entry = SkkVerbAdjectiveDictionary::Entry
  Parser = SkkVerbAdjectiveDictionary::JapaneseVerbAdjList::Parser

  def test_extracts_stems_and_tags
    [
      [%w[アイイレル 一段 相容れる], %w[あいいれ 相容れ @verb-1]],
      [%w[アイクルシイ 形容詞・イ段 愛くるしい], %w[あいくるし 愛くるし @adj]],
      [%w[カッコイイ 形容詞・イイ カッコいい], %w[かっこい カッコい @adj]],
      [%w[イク 五段・カ行促音便 イく], %w[い イ @verb-5-k-iku]],
      [%w[アリウル 一段・得ル 有り得る], %w[ありう 有り得 @verb-1-uru]],
      [%w[アイスル サ変・−スル 愛する], %w[あいす 愛す @verb-henkaku-s]]
    ].each do |source, expected|
      assert_equal expected, Entry.from_source(parse(source)).deconstruct
    end
  end

  def test_creates_one_canonical_kuru_entry_per_spelling
    assert_equal %w[く 来 @verb-henkaku-k], Entry.from_source(parse(%w[クル カ変・来ル 来る])).deconstruct
    assert_equal %w[く く @verb-henkaku-k], Entry.from_source(parse(%w[クル カ変・クル くる])).deconstruct
  end

  def test_rejects_a_row_with_mismatched_endings
    source = parse(%w[タベル 一段 食べた])

    assert_raises(ArgumentError) { Entry.from_source(source) }
  end

  private

  def parse(fields)
    reading, conjugation, spelling = fields
    Parser.parse_line([reading, conjugation, '', spelling, '1'].join("\t"))
  end
end
