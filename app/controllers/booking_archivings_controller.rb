class BookingArchivingsController < ApplicationController
    before_action :authenticate_user!

    def create
        b = Booking.find(params[:booking_id])
        if b.active? && can?(:archive, b)
            b.archive!
            flash[:success] = "Booking was successfully archived!"
            redirect_to archived_bookings_bookings_path
        elsif b.archived? && can?(:activate, b)
            b.activate!
            flash[:success] = "Booking status was successfully set to active!"
            redirect_to bookings_path
        else
            flash[:danger] = "Access Denied!"
            redirect_to bookings_path
        end
    end
end
