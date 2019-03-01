class SessionsController < ApplicationController
    def new
    end

    def create
        user = User.find_by_email params[:email]

        if user&.authenticate params[:password]
            session[:user_id] = user.id
            redirect_to occurences_path
            flash[:success] = "Hello #{user.first_name}, you are now logged in"
        else
            flash[:alert] = "Email or password were incorrect"
            render :new
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to root_path
        flash[:success] = "You were successfully logged out"
    end
end
