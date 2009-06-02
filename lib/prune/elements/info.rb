# coding:utf-8

require "date"

module Prune 
  module Elements
    class Info < Base
      include Prune

      def initialize(pdf)
        super(pdf)
        date = DateTime.now
        creation_date = date.strftime("D:%Y%m%d%H%M%S") +
          date.zone.sub(/:/, "'") + "'"
        @content = pd!(
          pn!(:CreationDate) => pl!(creation_date),
          pn!(:ModDate) => pl!(creation_date),
          pn!(:Author) => pl!("UNKNOWN"),
          pn!(:Title) => pl!("UNKNOWN"),
          pn!(:Creator) => pl!("#{APPLICATION}-#{VERSION}"),
          pn!(:Producer) => pl!("#{APPLICATION}-#{VERSION}"))
        register
      end

      def title=(title)
        @content[pn!(:Title)] = pl!(title)
      end

      def author=(author)
        @content[pn!(:Author)] = pl!(author)
      end
    end
  end
end
