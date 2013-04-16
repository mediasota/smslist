require 'nokogiri'
require 'smslist/configuration'
require 'smslist/client'

module Smslist
  extend Configuration
  class << self
    # Alias for Smslist::Client.new
    #
    # @return [Smslist::Client]
    def new(options = {})
      Smslist::Client.new(options)
    end

    # Delegate to Smslist::Client.new
    def method_missing(method, *args, &block)
      return super unless new.respond_to?(method)
      new.send(method, *args, &block)
    end

    def respond_to?(method, include_private = false)
      new.respond_to?(method, include_private) || super(method, include_private)
    end
  end
end