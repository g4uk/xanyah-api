# frozen_string_literal: true

class Plan < ApplicationRecord
  after_create :create_stripe_plans

  enum status: {inactive: 0, active: 1}

  monetize :monthly_price_cents
  monetize :yearly_price_cents

  def end_date_from(date=nil)
    date ||= Date.current.to_date
    interval_count.send(interval).from_now(date)
  end

  private

  def create_stripe_plans
    Stripe::Plan.create(
      id:       "#{gateway_id}_monthly",
      amount:   monthly_price_cents,
      currency: :eur,
      interval: :month,
      product:  {
        name: "#{gateway_id} - Monthly"
      }
    )
    Stripe::Plan.create(
      id:       "#{gateway_id}_yearly",
      amount:   yearly_price_cents,
      currency: :eur,
      interval: :year,
      product:  {
        name: "#{gateway_id} - Yearly"
      }
    )
  end
end
