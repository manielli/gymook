class BookingsController < ApplicationController
    before_actions :authenticate_user!

    def create
        occurence = Occurence.find(params[:occurence_id])
        gym_class = occurence.gym_class
        booking = Booking.new(occurence: occurence, user: current_user)

        if !can?(:book, occurence)
            flash[:warning] = "We couldn't complete your booking"
        elsif booking.save
            flash[:success] = "Your class was successfully booked"
        else
            flash[:danger] = booking.errors.full_messages.join(", ")
        end

        redirect_to gym_class_path(gym_class.id)
    end

    def show
        occurence = Occurence.find params[:id]
        booking = occurence.booking.find_by(user: current_user, occurence: occurence.id)
    end

    def index
        
    end

    def destroy
        booking = current_user.bookings.find(params[:id])
        gym_class = booking.occurence.gym_class

        if can?(:delete, booking)
            booking.destroy
            flash[:success] = "You booking has been cancelled!"
        else
            flash[:danger] = "We couldn't cancel your booking, something went wrong..."
        end

        redirect_to gym_class_path(gym_class.id)
    end
end
