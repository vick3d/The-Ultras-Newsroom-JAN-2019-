class SubscriptionsController < ApplicationController
  before_action :mock_stripe_in_test
  
  def index
  end

  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      source: stripe_token(params),
      description: 'premium subscription'
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: 10_000,
      currency: 'sek',
      description: '1 month subscription Vikings times'
    )
    
    if charge[:paid]
      redirect_to root_path, notice: "You have successfully subscribed!"
    else
      redirect_to subscriptions_path, notice: "Something went very wrong!"
  
    end
  end

  private

  def stripe_token(params)
		Rails.env.test? ? generate_test_token : params[:stripeToken]
	end

 	def generate_test_token
		StripeMock.generate_card_token
	end

 	def mock_stripe_in_test
		StripeMock.start if Rails.env.test?
  end
  
end
