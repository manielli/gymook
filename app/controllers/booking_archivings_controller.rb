class BookingArchivingsController < ApplicationController
    before_action :authenticate_user!

    def create
        b = Booking.find(params[:booking_id])
        if b.active? && can?(:archive, b)
            b.archive!
            flash[:success] = "Booking was successfully archived!"
        elsif b.archived? && can?(:activate, b)
            b.activate!
            flash[:success] = "Booking status was successfully set to active!"
        else
            flash[:danger] = "Access Denied!"
        end

        redirect_to booked_occurences_path
    end

end
