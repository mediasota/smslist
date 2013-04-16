require 'httparty'

module Smslist
  module Request
    def post(xml, method = nil)
      HTTParty.post request_uri(method), :body => xml, :headers => headers
    end

    def build_xml_body(&block)
      Nokogiri::XML::Builder.new(:encoding => 'utf-8') do |xml|
        xml.request {
          xml.security {
            authentication.each { |k, v| xml.send(k, :value => v) }
          }
          xml.instance_eval(&block) if block_given?
        }
      end
    end

    private

    def headers
      {
        'Content-type' => 'text/xml; charset=utf-8',
        'User-Agent' => Configuration::DEFAULT_USER_AGENT
      }
    end

    def request_uri(method = nil)
      if method && Configuration::METHOD_ENDPOINTS.include?(method)
        [Configuration::DEFAULT_API_ENDPOINT, method.to_s + '.php'].join
      else
        Configuration::DEFAULT_API_ENDPOINT
      end
    end
  end
end