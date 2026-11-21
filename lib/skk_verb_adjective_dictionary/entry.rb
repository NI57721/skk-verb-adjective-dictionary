# frozen_string_literal: true

require_relative 'conjugation_tag'

module SkkVerbAdjectiveDictionary
  # A dictionary stem and its candidate before SKK formatting.
  Entry = Data.define(:reading, :spelling, :tag) do
    def self.from_source(source)
      reading = source.reading.tr('ァ-ヶ', 'ぁ-ゖ')
      spelling = source.spelling
      if reading.length < 2 || spelling.length < 2 || reading[-1] != spelling[-1].tr('ァ-ヶ', 'ぁ-ゖ')
        raise ArgumentError, "Cannot extract stem from #{[reading, spelling].inspect}"
      end

      new(reading: reading.chop, spelling: spelling.chop, tag: ConjugationTag.fetch(source.conjugation))
    end
  end
end
