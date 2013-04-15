module Smslist
  module Configuration
    VALID_OPTIONS_KEYS = [
      :api_endpoint,
      :login,
      :password,
      :token,
      :user_agent,
      :sender
    ].freeze

    METHOD_ENDPOINTS = [
      :state,
      :balance,
      :incoming,
      :def,
      :list_bases,
      :bases,
      :list_phones,
      :phones,
      :delete_phones,
      :stop,
      :list_sheduled,
      :scheduled
    ].freeze

    DEFAULT_API_ENDPOINT = 'https://my.smscell.ru/xml/'
    DEFAULT_USER_AGENT = "Smslist Ruby Gem #{Smslist::VERSION}".freeze

    attr_accessor(*VALID_OPTIONS_KEYS)

    def self.extended(base)
      base.reset
    end

    def configure
      yield self
    end

    def options
      VALID_OPTIONS_KEYS.inject({}) { |o, k| o.merge!(k => send(k)) }
    end

    def reset
      self.user_agent = DEFAULT_USER_AGENT
      self.api_endpoint = DEFAULT_API_ENDPOINT
      self.login = nil
      self.password = nil
      self.token = nil
      self.sender = nil
    end
  end
end