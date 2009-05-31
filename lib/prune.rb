# coding:utf-8

# Path of the library
prune_path = File.join(File.dirname(__FILE__), "prune")
prune_fullpath = File.expand_path(prune_path)

# Add to the load path of ruby
$:.unshift(prune_path) unless
  $:.include?(prune_path) || $:.include?(prune_fullpath)

# version
require "version"

# DSL parser
require "parsers/document/properties/description_parser"
require "parsers/document/properties_parser"
require "parsers/document/page_parser"
require "parsers/document_parser"



require "pdf_constants"
require "pdf_errors"
require "pdf_types"
require "pdf_objects"
require "pdf_handlers"
require "pdf_fonts"
require "pdf_functions"
require "document"

module Prune
  def self.pdf(file_path, &block)
    @document = Document.new
    @document_parser = Parsers::DocumentParser.new(@document)
    @document_parser.instance_eval(&block)
    puts @document.to_s
  end
end
