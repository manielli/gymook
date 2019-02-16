class OccurencesController < ApplicationController
    before_action :find_occurence, only: [:show, :destroy]
    before_action :authenticate_user!, except: [:show, :index]
    before_action :authorize_user!, only: [:destroy]

    def new
        @occurence = Occurence.new
        @gym_class = GymClass.find(params[:gym_class_id])
        user = current_user
        if can?(:create, @occurence)
            render :new
        else
            flash[:danger] = "Access Denied, you must be a coach to do this..."
            redirect_to root_path
        end
    end

    def create
        # byebug
        @occurence = Occurence.new occurence_params
        gym_class = GymClass.find(params[:gym_class_id])
        @occurence.gym_class = gym_class

        if @occurence.save && can?(:create, @occurence) 
            flash[:success] = "The occurence was successfully created..."
        else
            flash[:danger] = "Oops, something went wrong, occurence couldn't be created..."
        end
        redirect_to gym_class_occurence_path(gym_class, @occurence)
    end

    def show
    end

    def index
        @gym_class = GymClass.find(params[:gym_class_id])
        @occurences = @gym_class.occurences.all.order(created_at: :desc)
    end

    def destroy
        @occurence.destroy
        redirect_to gym_class_path(@occurence.gym_class)
    end


    private
    def occurence_params
        params.require(:occurence).permit(:start_time, :end_time)
    end

    def find_occurence
        @occurence = Occurence.find(params[:id])
    end

    def authorize_user!
        unless can?(:crud, @occurence)
            flash[:danger] = "Access Denied"
            redirect_to root_path
        end
    end
end
