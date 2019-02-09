class GymClassesController < ApplicationController
    before_action :find_gym_class, only: [:show]
    def new
        @gym_class = GymClass.new
    end

    def create
        @gym_class = GymClass.new gym_class_params

        if @gym_class.save
            redirect_to gym_class_path(@gym_class.id)
        else
            render :new
        end
    end

    def index
        @gym_classes = GymClass.all.order(created_at: :desc)

        render :index
    end

    def show
    end

    private
    def gym_class_params
        params.require(:gym_class).permit(:class_type, :description, :cost, :maximum_clients)
    end

    def find_gym_class
        @gym_class = GymClass.find params[:id]
    end
end
