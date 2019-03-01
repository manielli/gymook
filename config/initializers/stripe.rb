Stripe.api_key = ENV["STRIPE_SECRET_KEY"]
	
# Example transaction with Stripe:

# 1. Generate Stripe token with payment method. In this case, we used
#    a credit card. This returns a token. Use its `id` to charge the card.

# tok = Stripe::Token.create(
#   card: {
#     number: "4242424242424242", exp_month: 2, exp_year: 2020, cvc: "123"
# })

# 2. Then, create charge with a token's id as source. The following
#    charges 5.00 CAD to the token generated above.

# Stripe::Charge.create(amount: 500, currency: "cad", source: tok.id)