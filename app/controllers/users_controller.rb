class UsersController < ApplicationController
    before_action :find_user, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, except: [:new, :create]
    before_action :coach_authorize_user!, except: [:new, :create, :index]
    before_action :client_authorize_user!, only: [:show, :edit, :update, :new, :create, :index, :destroy]


    def new
        @user = User.new
    end

    def show
    end

    def index
        @users = User.all.order(first_name: :asc)
    end

    def create
        @user = User.new user_params
        if @user.save
            session[:user_id] = @user.id
            redirect_to root_path
            flash[:primary] = "You successfully signed up"
        else
            flash[:danger] = "Oops, something went wrong"
            render :new
        end
    end

    private
    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :role, :date_of_birth)
    end

    def find_user
        @user = User.find(params[:id])
    end

    def coach_authorize_user!
        unless can?(:crud, @user)
            flash[:danger] = "Access Denied!"
            redirect_to users_path
        end
    end

    def client_authorize_user!
        unless can?(:u, @user)
            flash[:danger] = "You are not authorized to make these changes"
            redirect_to users_path
        end
    end
end
