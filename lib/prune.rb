# coding:utf-8

# Path of the library.
prune_path = File.join(File.dirname(__FILE__), "prune")
prune_fullpath = File.expand_path(prune_path)

# Add to the load path of ruby.
$:.unshift(prune_path) unless
  $:.include?(prune_path) || $:.include?(prune_fullpath)

# Constants.
require "constants"

# Errors.
require "errors"

# PDF functions.
require "functions"

# PDF objects.
require "p_objects/base"
require "p_objects/p_hexadecimal_string"
require "p_objects/p_literal_string"
require "p_objects/p_name"
require "p_objects/p_stream"
require "p_objects/p_array"
require "p_objects/p_dictionary"

# PDF elements.
require "elements/base"
require "elements/catalog"
require "elements/font"
require "elements/font_descriptor"
require "elements/info"
require "elements/outlines"
require "elements/page"
require "elements/pages"
require "elements/procedure_sets"
require "elements/stream"

# fonts
require "fonts/base"
require "fonts/base_en"
require "fonts/en/courier"
require "fonts/en/helvetica"
require "fonts/en/symbol"
require "fonts/en/times_roman"
require "fonts/en/zapf_dingbats"
require "fonts/base_ja"
require "fonts/ja/ms_gothic"

# handlers
require "handlers/base"
require "handlers/text_handler"

# PDF document.
require "document"

# DSL parser.
require "parsers/base"
require "parsers/document/property_parser"
require "parsers/document/page_parser"
require "parsers/document_parser"

module Prune
  def self.pdf(filename, &block)
    unless /\.[pP][dD][fF]\z/ === filename
      filename += ".pdf"
    end
    @document = Document.new
    @document_parser = Parsers::DocumentParser.new(@document)
    @document_parser.instance_eval(&block)
    puts @document.to_s
    @document.save_as(filename)
  end
end
