# frozen_string_literal: true

class SubscriptionSerializer < ActiveModel::Serializer
  attributes :id, :started_at, :ended_at, :status, :payment_gateway, :payment_gateway_subscription_id
  has_one :store
  has_one :plan
end
