module Smslist
  class Error < StandardError
    def initialize(response = nil)
      @response = response
      super @response
    end
  end

  class UnauthorizedError < Error; end
  class NoSenderError < Error; end
end