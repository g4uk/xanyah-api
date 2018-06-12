# frozen_string_literal: true

class Subscription < ApplicationRecord
  attr_accessor :frequency, :stripe_token_id

  belongs_to :store
  belongs_to :plan

  enum status: {active: 0, inactive: 1, canceled: 2}
end
