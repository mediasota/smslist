module Smslist
  module Response
    def parse_xml(response)
      Nokogiri::XML(response.body).tap do |xml|
        error = xml.xpath('response/error').text
        raise Smslist::Error.new(error) unless error.empty?
      end
    end
  end
end