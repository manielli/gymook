class OccurencesController < ApplicationController
    before_action :find_occurence, only: [:show, :destroy]
    before_action :authenticate_user!, except: [:index]
    before_action :authorize_user!, only: [:destroy]
    before_action :user_is_coach?, only: [:show]

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
        @occurence = Occurence.new occurence_params
        gym_class = GymClass.find(params[:gym_class_id])
        @occurence.gym_class = gym_class

        if @occurence.save && can?(:create, @occurence) 
            flash[:success] = "The occurence was successfully created..."
            redirect_to gym_class_occurence_path(gym_class.id, @occurence.id)
        else
            flash[:danger] = "Oops, something went wrong, occurence couldn't be created..."
            redirect_to new_gym_class_occurence_path(gym_class.id)
        end
    end

    def show
        @bookings = @occurence.bookings.order(created_at: :desc)
    end

    def index
        @occurences = Occurence.all.order(created_at: :desc)
    end

    def destroy
        @occurence.destroy
        redirect_to gym_class_path(@occurence.gym_class.id)
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

    def user_is_coach?
        current_user.present? && current_user.role == "Coach"
    end
end
