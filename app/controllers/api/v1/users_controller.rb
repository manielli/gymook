class Api::V1::UsersController < Api::ApplicationController
    before_action :authenticate_user!

    def current
        render json: { status: 200, current_user: ActiveModelSerializers::SerializableResource.new(current_user).as_json }
    end

    def create
        user = User.new user_params
        user.role = "Client"
        if user.save!
            session[:user_id] = user.id
            render json: { status: 200 }, status: 200
        else
            render json: { status: 403 }, status: 403
        end
    end

    def show
        if can?(:crud, current_user) || current_user == user
            user = User.find(params[:id])
            render json: {id: user.id}
        end
    end

    def index
        if can?(:crud, current_user)
            users = User.all.order(first_name: :asc)
            render json: users
        else
            render json: { status: 403 }, status: 403
        end
    end

    def update
        if can?(:crud, current_user) || current_user == user
            if user.update user_params
                render json: { id: user.id }
            else
                render json: { status: 400 }, status: 400
            end
        end
    end

    def destroy
        if can?(:crud, current_user)
            user.destroy
            render json: { status: 200 }, status: 200
        end
    end

    private
    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :role, :date_of_birth)
    end

    def user
        @user ||= User.find(params[:id])
    end
end
