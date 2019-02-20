class PaymentsController < ApplicationController
    before_action :authenticate_user!

    def new
        @booking = Booking.find(params[:booking_id])
    end

    def create
        @booking = Booking.find(params[:booking_id])

        begin 
            charge = Stripe::Charge.create(
                amount: (@booking.occurence.gym_class.cost * 100).to_i,
                currency: "cad",
                source: params[:stripe_token],
                description: "Charge for the class with id: #{@booking.occurence.id}"
            )

            @booking.update(stripe_charge_id: charge.id)

            flash[:success] = "Thank you for your payment, you class is booked and payment has been processed."
            redirect_to booked_occurences_path
        rescue => error
            logger.error error.full_message
            flash.now[:danger] = "There was something wrong with your payment. Please try again or contact us."
            @booking.destroy
            redirect_to occurences_path
        end
    end
end
