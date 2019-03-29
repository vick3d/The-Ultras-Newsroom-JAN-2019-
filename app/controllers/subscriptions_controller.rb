class SubscriptionsController < ApplicationController
  def new
  end

  def create
    if user_signed_in? 
      customer = Stripe::Customer.create(
        email: current_user.email,
        source: stripe_token(params),
        description: 'The Viking Times subscription'
      )

      charge = Stripe::Charge.create(
        customer: customer.id,
        amount: 15_000,
        currency: 'sek',
        description: 'The Viking Times: 1 month subscription'
      )

      if charge[:paid]
        current_user.subscriber!    
        redirect_to root_path, notice: "You have successfully subscribed!"
      else
        redirect_to subscriptions_path, notice: "Something went very wrong!"
      end
    else 
      redirect_to new_subscription_path, notice: "You need to be logged in to buy a subscription"
    end
    rescue Stripe::CardError => e
    redirect_to(new_subscription_path, notice: e.message) && return
  end

  private

  def stripe_token(params)
    Rails.env.test? ? generate_test_token : params[:stripeToken]
  end

  def generate_test_token
    StripeMock.generate_card_token
  end
end
