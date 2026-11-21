# frozen_string_literal: true

module SkkVerbAdjectiveDictionary
  # Formats tagged stems as a UTF-8 SKK dictionary.
  module SkkFormatter
    HEADERS = [';; okuri-ari entries.', ';; okuri-nasi entries.'].freeze
    HIRAGANA_ONLY = /\A\p{Hiragana}+\z/
    private_constant :HEADERS, :HIRAGANA_ONLY

    def self.format(entries)
      grouped = entries.group_by(&:reading)
      lines = grouped.keys.sort.filter_map do |reading|
        group = grouped.fetch(reading)
        next if group.all? { |entry| entry.spelling.match?(HIRAGANA_ONLY) }

        candidates = candidate_tokens(reading, group)
        "#{reading} /#{candidates.join('/')}/"
      end
      "#{(HEADERS + lines).join("\n")}\n"
    end

    def self.candidate_tokens(reading, entries)
      alternatives = entries.reject { |entry| entry.spelling == reading }.group_by(&:tag)
      entries.filter_map do |entry|
        next if entry.spelling == reading && reading.match?(HIRAGANA_ONLY) && alternatives.key?(entry.tag)

        "#{entry.spelling};#{entry.tag}"
      end.uniq
    end
    private_class_method :candidate_tokens
  end
end
