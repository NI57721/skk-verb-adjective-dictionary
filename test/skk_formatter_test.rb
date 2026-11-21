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
end
