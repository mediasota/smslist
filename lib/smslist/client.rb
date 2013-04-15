require 'smslist/authentication'
require 'smslist/request'
require 'smslist/response'

require 'smslist/client/balance'
require 'smslist/client/sms'

module Smslist
  class Client
    attr_accessor(*Configuration::VALID_OPTIONS_KEYS)

    def initialize(options = {})
      options = Smslist.options.merge(options)

      Configuration::VALID_OPTIONS_KEYS.each do |key|
        self.send("#{key}=", options[key])
      end
    end

    include Smslist::Authentication
    include Smslist::Request
    include Smslist::Response

    include Smslist::Client::Balance
    include Smslist::Client::Sms
  end
end