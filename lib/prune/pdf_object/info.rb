# coding:utf-8

require "date"
require "pdf_object/base_object"

module Prune 
  module PdfObject
    class Info < BaseObject
      def initialize(pdf)
        super(pdf)
        date = DateTime.now
        creation_date = date.strftime("D:%Y%m%d%H%M%S") +
          date.zone.sub(/:/, "'") + "'"
        @content = PdfDictionary.new({
          :CreationDate => creation_date,
          :ModDate => creation_date,
          :Author => "UNKNOWN",
          :Title => "UNKNOWN",
          :Creator => "%s-%s)" % [APPLICATION, VERSION],
          :Producer => "%s-%s)" % [APPLICATION, VERSION]})
        register
      end

      def update(hash)
        hash.keys.each{|key|
          value = hash[key]
          case key
          when :Title
            @content[key] = value if value.is_a?(String)
          when :Author
            @content[key] = value if value.is_a?(String)
          end
        }
      end
    end
  end
end
