class BookingsController < ApplicationController
    before_action :authenticate_user!

    def create
        occurence = Occurence.find(params[:occurence_id])
        gym_class = occurence.gym_class
        booking = Booking.new(occurence: occurence, user: current_user)

        if !can?(:book, occurence)
            flash[:warning] = "You can not book your own occurence."
            redirect_to booked_occurences_path
        elsif booking.save
            # flash[:success] = "Your class was successfully booked."
            redirect_to new_booking_payment_path(booking.id)
        else
            flash[:danger] = booking.errors.full_messages.join(", ")
            redirect_to booked_occurences_path
        end

    end

    def index
        @bookings = Booking.all.viewable.order(created_at: :desc)
    end

    def destroy
        booking = current_user.bookings.find(params[:id])
        ocuurence = booking.occurence
        gym_class = ocuurence.gym_class

        if can?(:delete, booking)
            booking.destroy
            flash[:success] = "The booking was successfully cancelled"
        else
            flash[:warning] = "Can not cancel this booking, something went wrong..."
        end
        redirect_to booked_occurences_path
    end

    def archived_bookings
        @bookings = Booking.all.archived.order(created_at: :desc)
    end
end
