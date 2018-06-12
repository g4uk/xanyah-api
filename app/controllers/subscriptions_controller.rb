# frozen_string_literal: true

class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: %i[show update destroy]

  # GET /subscriptions
  def index
    @subscriptions = Subscription.all

    render json: @subscriptions
  end

  # GET /subscriptions/1
  def show
    render json: @subscription
  end

  # POST /subscriptions
  def create
    @subscription = Subscription.new(subscription_params)
    @plan = Plan.find(subscription_params[:plan_id])
    @store = Store.find(subscription_params[:store_id])
    @subscription.started_at = Time.zone.now

    if subscription_params[:frequency] == 'monthly'
      @subscription.ended_at = Time.zone.now + 1.month
      @amount = @plan.monthly_price_cents
    else
      @subscription.ended_at = Time.zone.now + 1.year
      @amount = @plan.yearly_price_cents
    end

    @subscription.payment_gateway = :stripe
    @subscription.payment_gateway_subscription_id = Stripe::Subscription.create(
      customer: @store.gateway_customer_id,
      items:    [
        plan: "#{@plan.gateway_id}_#{subscription_params[:frequency]}"
      ],
      source:   subscription_params[:stripe_token_id]
    ).id

    subscription_params.delete(:frequency)
    subscription_params.delete(:stripe_token_id)

    if @subscription.save
      render json: @subscription, status: :created, location: @subscription
    else
      render json: @subscription.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /subscriptions/1
  def update
    if @subscription.update(subscription_params)
      render json: @subscription
    else
      render json: @subscription.errors, status: :unprocessable_entity
    end
  end

  # DELETE /subscriptions/1
  def destroy
    @subscription.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_subscription
    @subscription = Subscription.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def subscription_params
    params.require(:subscription).permit(
      :frequency,
      :store_id,
      :plan_id,
      :stripe_token_id
    )
  end
end
