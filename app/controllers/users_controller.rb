class UsersController < ApplicationController
    before_action :find_user, only: [:edit, :update, :destroy]
    before_action :authenticate_user!, except: [:new, :create]

    def new
        @user = User.new
    end

    def create
        @user = User.new user_params
        @user.role = "Client"
        if @user.save
            session[:user_id] = @user.id
            redirect_to root_path
            flash[:primary] = "You successfully signed up"
        else
            flash[:danger] = "Oops, something went wrong"
            render :new
        end
    end

    
    def index
        if can?(:crud, current_user)
            @users = User.all.order(first_name: :asc)
        else
            flash[:danger] = "Access Denied!"
        end
    end
    
    def show
        if can?(:crud, current_user) || current_user == @user
            @user = User.find(params[:id])
        end
    end

    def edit
        if can?(:crud, current_user) || current_user == @user
            @user = User.find(params[:id])
        else
            flash[:danger] = "Access Denied!"
            redirect_to user_path(@user)
        end
    end

    def update
        if can?(:crud, current_user) || current_user == @user
            if @user.update user_params
                redirect_to user_path(@user)
                flash[:success] = "User details have been successfully updated."
            else
                render :edit
                flash[:danger] = "Access Denied! Couldn't update user details!"
            end
        end
    end

    def destroy
        if can?(:crud, current_user)
            @user.destroy
            redirect_to users_path
            flash[:success] = "User was successfully deleted"
        end
    end

    private
    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :role, :date_of_birth)
    end

    def find_user
        @user = User.find(params[:id])
    end
end
