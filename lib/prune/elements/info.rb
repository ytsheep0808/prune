# coding:utf-8
require "date"

module Prune 
  module Elements
    class Info < Base
      # Initialize.
      def initialize(document)
        super(document)
        date = DateTime.now
        creation_date = date.strftime("D:%Y%m%d%H%M%S")
        creation_date << date.zone.sub(/:/, "'") + "'"
        creator = "#{APPLICATION}-#{VERSION}"
        # Set dictionary.
        @content = pd(
          pn(:CreationDate) => pl(creation_date),
          pn(:ModDate) => pl(creation_date),
          pn(:Author) => pl("UNKNOWN"),
          pn(:Title) => pl("UNKNOWN"),
          pn(:Creator) => pl(creator),
          pn(:Producer) => pl(creator),
          pn(:Trapped) => pn(:False))
        # Register element to document.
        register
      end

      # Set title of the document.
      def title=(title)
        @content[pn(:Title)] = pl(title)
      end

      # Set subject of the document.
      def subject=(subject)
        @content[pn(:Subject)] = pl(subject)
      end

      # Set author of the document.
      def author=(author)
        @content[pn(:Author)] = pl(author)
      end
    end
  end
end
