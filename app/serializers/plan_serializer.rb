# frozen_string_literal: true

class PlanSerializer < ActiveModel::Serializer
  include MoneyRails::ActionViewExtension

  attributes :id,
             :gateway_id,
             :monthly_price,
             :yearly_price,
             :humanized_monthly_price,
             :humanized_yearly_price,
             :max_users,
             :max_variants

  def humanized_monthly_price
    humanized_money object.monthly_price
  end

  def humanized_yearly_price
    humanized_money object.yearly_price
  end
end
