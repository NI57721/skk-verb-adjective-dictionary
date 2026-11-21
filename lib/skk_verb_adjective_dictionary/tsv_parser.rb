# frozen_string_literal: true

require 'csv'

module SkkVerbAdjectiveDictionary
  module JapaneseVerbAdjList
    # Extracts the reading, conjugation, and spelling from one TSV row.
    class Parser
      attr_reader :reading, :conjugation, :spelling

      def initialize(row)
        @reading, @conjugation, @spelling = if row.is_a?(String)
                                              row.match(/\A([^\t]*)\t([^\t]*)\t[^\t]*\t([^\t]*)\t[^\t]*\n?\z/)&.captures
                                            else
                                              row.values_at(0, 1, 3)
                                            end
      end

      def self.parse_line(str)
        new(str)
      end

      def self.parse_tsv(tsv)
        CSV.foreach(tsv, col_sep: "\t", encoding: Encoding::UTF_8).map do |row|
          new(row)
        end
      end
    end
  end
end
