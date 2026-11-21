# frozen_string_literal: true

require_relative 'test_helper'
require 'skk_verb_adjective_dictionary/entry'
require 'skk_verb_adjective_dictionary/skk_formatter'

class SkkFormatterTest < Minitest::Test
  Entry = SkkVerbAdjectiveDictionary::Entry
  Formatter = SkkVerbAdjectiveDictionary::SkkFormatter

  EXPECTED = <<~SKK
    ;; okuri-ari entries.
    ;; okuri-nasi entries.
    え /える;@verb-1/得;@verb-1/える;@verb-5-r/
    く /来;@verb-henkaku-k/
  SKK

  def test_sorts_keys_and_preserves_candidate_order_and_distinct_tags
    entries = [
      Entry.new('く', '来', '@verb-henkaku-k'),
      Entry.new('え', 'える', '@verb-1'),
      Entry.new('え', '得', '@verb-1'),
      Entry.new('え', 'える', '@verb-5-r'),
      Entry.new('え', 'える', '@verb-1')
    ]

    assert_equal EXPECTED, Formatter.format(entries)
  end

  def test_omits_a_hiragana_candidate_only_when_its_tag_has_another_spelling
    entries = [
      Entry.new('く', 'く', '@verb-5-m'),
      Entry.new('く', '組', '@verb-5-m'),
      Entry.new('く', 'く', '@verb-henkaku-k'),
      Entry.new('く', '汲', '@verb-5-m'),
      Entry.new('あどけな', 'あどけな', '@adj')
    ]

    assert_equal ["あどけな /あどけな;@adj/\n", "く /組;@verb-5-m/く;@verb-henkaku-k/汲;@verb-5-m/\n"],
                 Formatter.format(entries).lines.drop(2)
  end
end
