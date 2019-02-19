class Api::V1::BookingsController < Api::ApplicationController
    before_action :authenticate_user!

    def create
        occurence = Occurence.find(params[:occurence_id])
        gym_class = occurence.gym_class
        booking = Booking.new(occurence: occurence, user: current_user)

        if !can?(:book, occurence)
            render json: { status: 401 }, status: 401
        elsif booking.save!
            render json: {id: booking.id}
        else
            render json: 
        end
    end

    def index
        bookings = Booking.all.viewable.order(created_at: :desc)
        render json: bookings
    end

    def destroy
        booking = current_user.bookings.find(params[:id])
        occurence = booking.occurence
        gym_class = occurence.gym_class

        if can?(:delete, booking)
            booking.destroy!
            render json: { status: 200 }, status: 200
        else
            render json: { status: 403 }, status: 403
        end
    end

    private
    def booking
        @booking ||= Booking.find(params[:id])
    end
end
