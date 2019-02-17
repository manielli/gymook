class BookingsController < ApplicationController
    before_action :authenticate_user!

    def create
        occurence = Occurence.find(params[:occurence_id])
        gym_class = occurence.gym_class
        booking = Booking.new(occurence: occurence, user: current_user)

        if booking.save
            flash[:success] = "Your class was successfully booked"
        else
            flash[:danger] = booking.errors.full_messages.join(", ")
        end

        redirect_to occurences_path
    end


    def destroy
        booking = current_user.bookings.find(params[:id])
        ocuurence = booking.occurence
        gym_class = ocuurence.gym_class

        booking.destroy
        flash[:success] = "You booking was successfully cancelled"
        redirect_to occurences_path
    end

    private
    def booking_params
        params.require(:booking)
    end

    def find_booking
        @booking = Booking.find(params[:id])
    end

    def authorize_user!
        unless can?(:crud, @booking)
            flash[:danger] = "You are not allowed to make this booking..."
            redirect_to occurences_path
        end
    end
end
