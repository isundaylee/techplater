require "techplater/version"
require 'nokogiri'

module Techplater
  class Parser
    attr_reader :chunks

    HANDLEBARS_TEMPLATE_VERBATIM = "{{chunks.[%d]}}"

    def initialize(text)
      @text = text
    end

    def parse!
      @chunks = []
      @template = []

      doc = Nokogiri::HTML.fragment(@text)

      doc.children.each do |p|
        process_node(p)
      end

      @chunks.compact!
    end

    def template
      @template.join("\n")
    end

    private
      def process_node(node)
        # Note that in handlebars the index starts at 1

        chunk = get_chunk(node)
        @chunks << get_chunk(node) if chunk
        tag = get_template_tag(node, chunk && @chunks.size)
        @template << tag if tag
      end

      def get_chunk(node)
        case node.name.to_sym
        when :h1, :h2, :h3, :h4, :h5, :h6, :p, :blockquote
          node
        else
          nil
        end
      end

      def get_template_tag(node, current_chunk_index)
        case node.name.to_sym
        when :h1, :h2, :h3, :h4, :h5, :h6, :p, :blockquote
          HANDLEBARS_TEMPLATE_VERBATIM % current_chunk_index
        end
      end
  end
end
