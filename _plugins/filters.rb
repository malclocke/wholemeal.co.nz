require 'nokogiri'
module Jekyll

  module Filters

    def first_paragraph(input)
      elems = Nokogiri::HTML.parse(input)
      elems.xpath('//p').first
    end

  end
end
