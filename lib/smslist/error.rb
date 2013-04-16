module Smslist
  class Error < StandardError
    def initialize(response = nil)
      @response = response
      super(build_error_message)
    end

    private

    def build_error_message
      return nil if @response.nil?

      if @response.is_a?(String)
        @response
      else
        body = Nokogiri::XML(body)
        body.xpath('response/error').text || ''
      end
    end
  end

  class UnauthorizedError < Error; end
  class NoSenderError < Error; end
end