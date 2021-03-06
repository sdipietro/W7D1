class SessionsController < ApplicationController
    def new
        render :new
    end

    def create
        user = User.find_by_credentials(params[:user, :username], params[:user, :password])
        if user.nil?
            flash.now[:errors] = "Incorrect Username / Password"
            render :new
        else
            user.reset_session_token!
            session[:session_token] = user.session_token
            flash.now[:success] = "Login Successful!"
            redirect_to cats_url
        end
    end

    def destroy
        current_user.reset_session_token!
        session[:session_token]
    end
end
