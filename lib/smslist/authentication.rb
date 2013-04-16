module Smslist
  module Authentication
    def authentication
      if token
        {:token => token}
      elsif login && password
        {:login => login, :password => password}
      else
        {}
      end
    end

    def authenticated?
      !authentication.empty?
    end
  end
end