class ApplicationController < ActionController::Base
    helper_method :current_user
    
    def current_user
        return nil unless session[:session_token]
        current = User.find_by(session_token: session[:session_token])
        current
    end
end
