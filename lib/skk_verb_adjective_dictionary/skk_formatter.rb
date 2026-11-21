# frozen_string_literal: true

module SkkVerbAdjectiveDictionary
  # Formats tagged stems as a UTF-8 SKK dictionary.
  module SkkFormatter
    HEADERS = [';; okuri-ari entries.', ';; okuri-nasi entries.'].freeze
    private_constant :HEADERS

    def self.format(entries)
      grouped = entries.group_by(&:reading)
      lines = grouped.keys.sort.map do |reading|
        candidates = grouped.fetch(reading).map { |entry| "#{entry.spelling};#{entry.tag}" }.uniq
        "#{reading} /#{candidates.join('/')}/"
      end
      "#{(HEADERS + lines).join("\n")}\n"
    end
  end
end
