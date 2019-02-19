class Api::V1::OccurencesController < Api::ApplicationController
    before_action :authenticate_user!

    def create
        occurence = Occurence.new occurence_params
        gym_class = GymClass.find(params[:gym_class_id])
        occurence.gym_class = gym_class
        occurence.user = current_user

        occurence.save!
        render json: {id: occurence.id}
    end

    def show
        bookings = occurence.bookings.order(created_at: :desc)
        render json: occurence
    end

    def index
        occurences = Occurence.order(start_time: :asc)
        render json: occurences
    end

    def destroy
        occurence.destroy!
        
        if can?(:delete, occurence)
            occurence.destroy
            render json: { status: 200 }, status: 200
        else
            render json: { status: 403 }, status: 403
        end
    end

    def booked
        occurences = current_user.booked_occurences.all.order(start_time: :asc)
        render json: occurences
    end

    private
    def occurence
        @occurence ||= Occurence.find params[:id]
    end

    def occurence_params
        params.require(:occurence).permit(:start_time, :end_time)
    end
end
