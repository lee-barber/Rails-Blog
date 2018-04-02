class SessionsController < ApplicationController
    def new
    end
    
    def create
        @user = User.find_by_username(params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id 
            flash[:message] = 'You are now logged in.'
            redirect_to "/blogs"
        else 
            flash[:message] = 'Sorry, please try again.'
            redirect_to '/login'
        end
    end

    def destroy
        session[:user_id] = nil
        flash[:message] = 'You are now logged out.'
        redirect_to '/login'
    end
end