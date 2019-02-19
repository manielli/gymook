class Api::V1::GymClassesController < Api::ApplicationController
    before_action :authenticate_user!, except: [:index, :show]

    def create
        gym_class = GymClass.new gym_class_params
        gym_class.user = current_user

        gym_class.save!
        render json: {id: gym_class.id}
    end

    def index
        gym_classes = GymClass.order(created_at: :desc)
        render json: gym_classes
    end

    def show
        render json: gym_class
    end

    def update
        gym_class.update! gym_class_params
        render json: {id: gym_class.id}
    end

    def destroy
        if can?(:delete, gym_class)
            gym_class.destroy
            render(json: {status: 200}, status: 200)
        else
            render(json: {status: 403}, status: 403)
        end
    end

    private
    def gym_class
        @gym_class ||= GymClass.find params[:id]
    end

    def gym_class_params
        params.require(:gym_class).permit(:class_type, :description, :cost, :maximum_clients)
    end
end
