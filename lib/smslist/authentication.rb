module Smslist
  module Authentication
    def authentication
      if token
        {:token => token}
      elsif login && password
        {:login => login, :password => password}
      else
        raise Smslist::UnauthorizedError.new('Access token, or login '\
          'and password are not initialized')
      end
    end
  end
end