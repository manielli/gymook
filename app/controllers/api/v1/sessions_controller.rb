class Api::V1::SessionsController < Api::ApplicationController
    def create
        user = User.find_by(email: params[:email])

        if user&.authenticate(params[:password])
            session[:user_id] = user.id
            render json: { status: 200, user: ActiveModelSerializers::SerializableResource.new(user).as_json }, status: 200
        else
            render json: { status: 404 }, status: 404
        end
    end

    def destroy
        session[:user_id] = nil
        render json: { status: 200 }, status: 200
    end
end
