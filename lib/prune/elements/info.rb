# coding:utf-8
require "date"

module Prune 
  module Elements
    class Info < Base
      def initialize(document)
        super(document)
        date = DateTime.now
        creation_date = date.strftime("D:%Y%m%d%H%M%S") +
          date.zone.sub(/:/, "'") + "'"
        creator = "#{APPLICATION}-#{VERSION}"
        @content = pd(
          pn(:CreationDate) => pl(creation_date),
          pn(:ModDate) => pl(creation_date),
          pn(:Author) => pl("UNKNOWN"),
          pn(:Title) => pl("UNKNOWN"),
          pn(:Creator) => pl(creator),
          pn(:Producer) => pl(creator),
          pn(:Trapped) => pn(:False))
        register
      end

      def title=(title)
        @content[pn(:Title)] = pl(title)
      end

      def subject=(subject)
        @content[pn(:Subject)] = pl(subject)
      end

      def author=(author)
        @content[pn(:Author)] = pl(author)
      end
    end
  end
end
