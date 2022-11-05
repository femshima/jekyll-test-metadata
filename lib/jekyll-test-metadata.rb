# frozen_string_literal: true

require_relative 'jekyll-test-metadata/version'

module JekyllTestMetadata
  class Error < StandardError; end

  class URLMappingGenerator < Jekyll::Generator
    safe true

    def generate(site)
      output_path = site.config.dig('test_metadata', 'output_path') || 'url_mapping.json'
      data = site.pages.map { |page| [page.url, [page.path, check?(page)]] }.to_h
      File.write(output_path, JSON[data])
    end

    private

    def check?(page)
      !!page.data['check']
    end
  end
end
