# frozen_string_literal: true

require_relative 'test_helper'
require 'skk_verb_adjective_dictionary/conjugation_tag'
require 'skk_verb_adjective_dictionary/source_dictionary'
require 'skk_verb_adjective_dictionary/tsv_parser'

class ConjugationTagTest < Minitest::Test
  Tag = SkkVerbAdjectiveDictionary::ConjugationTag
  Parser = SkkVerbAdjectiveDictionary::JapaneseVerbAdjList::Parser

  EXPECTED_TAGS = {
    'カ変・クル' => '@verb-henkaku-k',
    'カ変・来ル' => '@verb-henkaku-k',
    'サ変・−スル' => '@verb-henkaku-s',
    'サ変・−ズル' => '@verb-henkaku-z',
    'サ変・スル' => '@verb-henkaku-s',
    '一段' => '@verb-1',
    '一段・クレル' => '@verb-1-kureru',
    '一段・得ル' => '@verb-1-uru',
    '下二・カ行' => '@verb-bungo-2-shimo-k',
    '下二・ガ行' => '@verb-bungo-2-shimo-g',
    '下二・マ行' => '@verb-bungo-2-shimo-m',
    '下二・ラ行' => '@verb-bungo-2-shimo-r',
    '五段・カ行イ音便' => '@verb-5-k',
    '五段・カ行促音便' => '@verb-5-k-iku',
    '五段・カ行促音便ユク' => '@verb-5-k-yuku',
    '五段・ガ行' => '@verb-5-g',
    '五段・サ行' => '@verb-5-s',
    '五段・タ行' => '@verb-5-t',
    '五段・ナ行' => '@verb-5-n',
    '五段・バ行' => '@verb-5-b',
    '五段・マ行' => '@verb-5-m',
    '五段・ラ行' => '@verb-5-r',
    '五段・ラ行特殊' => '@verb-5-r-aru',
    '五段・ワ行ウ音便' => '@verb-5-w-tou',
    '五段・ワ行促音便' => '@verb-5-w',
    '形容詞・アウオ段' => '@adj',
    '形容詞・イイ' => '@adj',
    '形容詞・イ段' => '@adj'
  }.freeze

  def test_maps_each_classification_to_its_tag
    EXPECTED_TAGS.each do |classification, tag|
      assert_equal tag, Tag.fetch(classification), classification
    end
  end

  def test_rejects_unknown_classification
    assert_raises(KeyError) { Tag.fetch('未分類') }
  end

  def test_all_source_rows_have_a_tag
    path = SkkVerbAdjectiveDictionary::SourceDictionary.path
    entries = Parser.parse_tsv(path)

    refute_empty entries
    unknown = entries.map(&:conjugation).uniq - EXPECTED_TAGS.keys
    assert_empty unknown
  end
end
