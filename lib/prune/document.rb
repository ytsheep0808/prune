# coding:utf-8

require "pdf_constants"
require "pdf_types"
require "pdf_objects"
require "pdf_errors"

module Prune
  class Document
    include PdfObject
    include PdfType

    attr_reader :catalog, :pages, :outlines, :info, :proc_set
    attr_reader :font_hash, :object_list
    attr_writer :version

    def initialize(args = {})
      # Check if this argument is a hash
      raise ArgumentError unless args.is_a?(Hash)
      # 初期化
      @object_list = []
      @font_hash = {}
      @version = "1.2"
      # 概要の登録
      @info = Elements::Info.new(self)
      # カタログの登録
      @catalog = Catalog.new(self)
      @catalog.update(args)
      # アウトライン群の登録
      outlines = Outlines.new(self)
      @catalog.outlines = outlines
      # ページ群の登録
      @pages = Pages.new(self)
      @catalog.pages = @pages
      # ProcSet
      @proc_set = Elements::ProcedureSets.new(self)
    end

    # Add a new page
    def add_page(size = :A4)
      # Check document size
      raise DocumenteSizeError unless DOCUMENT_SIZE.include?(size)
      # Create a new page
      page = Page.new(self, DOCUMENT_SIZE[size])
      # Add page to pages
      @pages << page
      return page
    end

    # Get page.
    def page(no)
      @pages.page(no)
    end

    # Save pdf document to a file.
    def save_as(filename)
      raise MalFormedDocumentError if @pages.empty?
      # Write to a file
      File.open(filename, "wb") do |file|
        file.write self.to_s
      end
    end

    # Convert to String.
    def to_s
      # Write header
      out = []
      out << "%PDF-#{@version}"
      out << "%" + [0xE2, 0xE3, 0xCF, 0xD3].pack("c*")
      # Write objects
      out += @object_list.collect{|object| object.to_s}
      # Write cross-reference table
      out += cross_reference_table(@object_list.size, out.join(LF))
      # Write trailer
      out += trailer(out.join(LF))
      out << "%%EOF"
      out.join(LF)
    end

    private
    def cross_reference_table(objects, source)
      out = []
      out << "xref"
      out << "0 %d" % (objects + 1)
      out << "0000000000 65535 f"
      # オフセットの計算
      pos = 0
      while index = source.index(/^\d+ \d+ obj/, pos)
        out << "%010d %05d %s" % [index, 0, "n"]
        pos = index + 1
      end
      out
    end

    def trailer(source)
      out = []
      out << "trailer"
      dict = PdfDictionary.new({
        :Size => (@object_list.size + 1),
        :Root => @catalog})
      dict.update(:Info => @info) if @info
      out << dict.to_s
      out << "startxref"
      out << source.index("xref")
      out
    end

    def inspect
      self.to_s
    end
  end
end

