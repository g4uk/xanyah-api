# frozen_string_literal: true

class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions, id: :uuid do |t|
      t.belongs_to :store, foreign_key: true, type: :uuid
      t.belongs_to :plan, foreign_key: true, type: :uuid
      t.datetime :started_at
      t.datetime :ended_at
      t.integer :status
      t.string :payment_gateway
      t.string :payment_gateway_subscription_id

      t.timestamps
    end
  end
end
