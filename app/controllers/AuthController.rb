class AuthController < ApplicationController
  # /login
    def create
      #.includes(:items) will serialize the items associated to user, switch with folders/workouts once they are built? or just add them to serializer
      @user = User.find_by(username: user_params[:username])

      if @user && @user.authenticate(user_params[:password])
        jwt = self.issue_token(@user)
        render json: {user: @user, jwt: jwt}

      else
        render json: { error: 'Unable to log in, please try again', status: 401 }
      end
    end
  # /authorize
    def show
      @user = User.find(self.user_id)
      if @user && self.logged_in?
        render json: {user: @user, jwt: self.token}
      else
        render json: { error: 'User cannot be found', status: 401 }
      end
    end
    
  
    private
    
    def user_params
      params.require(:user).permit(:username, :password)
    end
end