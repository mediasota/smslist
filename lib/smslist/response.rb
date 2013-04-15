module Smslist
  module Response
    def parse_xml(response)
      Nokogiri::XML(response.body)
    end
  end
end