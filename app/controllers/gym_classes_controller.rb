class GymClassesController < ApplicationController
    before_action :find_gym_class, only: [:edit, :update, :show, :destroy]
    before_action :authenticate_user!, except: [:index, :show]
    before_action :authorize_user!, only: [:show, :edit, :destroy]

    def new
        @gym_class = GymClass.new
        user = current_user
        if can?(:create, @gym_class)
            render :new
        else
            flash[:danger] = "Access Denied!"
            redirect_to root_path
        end
    end

    def create
        @gym_class = GymClass.new gym_class_params
        @gym_class.user = current_user
        if @gym_class.save
            flash[:primary] = "The Gym Class was successfully created!"
            redirect_to gym_class_path(@gym_class.id)
        else
            render :new
            flash[:alert] = "Oops, something went wrong... we couldn't create the Gym Class for you..."
        end
    end

    def index
        @gym_classes = GymClass.all.order(created_at: :desc)
    end

    def show
        @occurences = @gym_class.occurences.order(created_at: :desc)
    end

    def edit
    end

    def update
        if @gym_class.update gym_class_params
            redirect_to gym_class_path(@gym_class)
        else
            render :edit
        end
    end

    def destroy
        @gym_class.destroy
        redirect_to gym_classes_path
    end

    private
    def gym_class_params
        params.require(:gym_class).permit(:class_type, :description, :cost, :maximum_clients)
    end

    def find_gym_class
        @gym_class = GymClass.find params[:id]
    end

    def authorize_user!
        unless can?(:crud, @gym_class)
            flash[:danger] = "Access Denied!"
            redirect_to root_path
        end
    end
end
