# frozen_string_literal: true

FactoryBot.define do
  factory :subscription do
    store nil
    plan nil
    started_at '2018-06-05 14:32:01'
    ended_at '2018-06-05 14:32:01'
    status 1
    payment_gateway 'MyString'
    payment_gateway_subscription_id 'MyString'
  end
end
