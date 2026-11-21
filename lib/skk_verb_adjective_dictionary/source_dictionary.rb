# frozen_string_literal: true

require 'digest'
require 'fileutils'
require 'json'
require 'tempfile'

module SkkVerbAdjectiveDictionary
  # Fetches the pinned upstream TSV and verifies its cached contents on each use.
  module SourceDictionary
    COMMIT_FILE = File.expand_path('../../data/upstream.json', __dir__)
    CACHE_DIR = File.expand_path('../../build/source', __dir__)
    URL = 'https://raw.githubusercontent.com/hiroshi-manabe/japanese_verb_adj_list'
    private_constant :COMMIT_FILE, :CACHE_DIR, :URL

    def self.path
      commit, sha256 = JSON.parse(File.read(COMMIT_FILE)).values_at('commit', 'sha256')
      unless /\A[0-9a-f]{40}\z/.match?(commit) && /\A[0-9a-f]{64}\z/.match?(sha256)
        raise ArgumentError, "Invalid upstream dictionary lock file: #{COMMIT_FILE}"
      end

      cached = File.join(CACHE_DIR, "#{sha256}.tsv")
      download(commit, sha256, cached) unless File.file?(cached) && Digest::SHA256.file(cached).hexdigest == sha256
      cached
    end

    def self.download(commit, sha256, cached)
      FileUtils.mkdir_p(CACHE_DIR)
      Tempfile.create('.upstream-', CACHE_DIR) do |file|
        system('curl', '--fail', '--silent', '--show-error', '--location', '--retry', '3', '--max-time', '60',
               '--output', file.path, "#{URL}/#{commit}/japanese_verb_adj_list.tsv", exception: true)
        unless Digest::SHA256.file(file.path).hexdigest == sha256
          raise "Upstream dictionary checksum mismatch for #{commit}"
        end

        File.rename(file.path, cached)
      end
    end
    private_class_method :download
  end
end
