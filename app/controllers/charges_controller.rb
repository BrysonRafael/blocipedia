class ChargesController < ApplicationController
  include ChargesHelper
  def create
    Stripe.api_key = "sk_test_Xo8AAESZajnBsYkxzYTQcgzl"


    plan = stripe.Plan.create(
      name="Basic Plan",
      id="basic-monthly",
      interval="month",
      currency="usd",
      amount=0,
    )

    plan = Stripe::Plan.create(
      :name => "Premium Plan",
      :id => "premium-monthly",
      :interval => "month",
      :currency => "usd",
      :amount => 1000,
    )

    # Creates a Stripe Customer object, for associating
    # with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    Stripe::Subscription.create(
      :customer => customer.id,
      :plan => "basic-monthly",
    )

    # Where the real magic happens
    charge = Stripe::Charge.create(
      customer: customer.id, # Note -- this is NOT the user_id in your app
      amount: Amount.default,
      description: "Premium Membership - #{current_user.email}",
      currency: 'usd'
    )

    flash[:notice] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
    redirect_to "/" # or wherever

    # Stripe will send back CardErrors, with friendly messages
    # when something goes wrong.
    # This `rescue block` catches and displays those errors.
    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end

  def new
   @stripe_btn_data = {
     key: "#{ Rails.configuration.stripe[:publishable_key] }",
     description: "Premium Membership - #{current_user.email}",
     amount: Amount.default
   }
  end

  def edit
    Stripe.api_key = "sk_test_Xo8AAESZajnBsYkxzYTQcgzl"

    subscription = Stripe::Subscription.retrieve("sub_9sncpu2x5mSXrQ")
    subscription.plan = "basic-monthly"
    subscription.save
  end
end
