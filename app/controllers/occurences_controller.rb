class OccurencesController < ApplicationController
    before_action :find_occurence, only: [:destroy]
    before_action :authenticate_user!
    before_action :authorize_user!, only: [:destroy]

    def create
        @gym_class = GymClass.find params[:gym_class_id]
        @occurence = Occurence.new occurence_params
        @occurence.gym_class = @gym_class

        @occurence.user = current_user
        if @occurence.save
            redirect_to gym_class_path(@occurence)
        else
            @occurences = @gym_class.occurences.order(created_at: :desc)
        end
    end

    def 

    def destroy
        @occurence.destroy
        redirect_to gym_class_path(@occurence)
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
            redirect_to gym_class_path(@occurence.gym_class)
        end
    end
end
