
class ApplicationController < ActionController::API
    def issue_token(user)
        JWT.encode({ user_id: user.id }, ENV['SECRET'], ENV['ALG'])
    end
  
    def current_user
      @user ||= User.find(self.user_id)
    end
  
    def token
      request.headers['Authorization']
    end
  
    def decoded_token
      begin
        JWT.decode(token, ENV['SECRET'], true, { alg: ENV['ALG'] })
      rescue JWT::DecodeError
        [ { error: 'invalid token' } ]
      end
    end
  
    def user_id
      self.decoded_token.first['user_id']
    end
  
    def logged_in?
      !!self.current_user
    end
end
