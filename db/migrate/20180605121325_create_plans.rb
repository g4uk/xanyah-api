# frozen_string_literal: true

class CreatePlans < ActiveRecord::Migration[5.1]
  def change
    create_table :plans, id: :uuid do |t|
      t.string :gateway_id
      t.monetize :monthly_price
      t.monetize :yearly_price
      t.integer :status
      t.integer :max_users
      t.integer :max_variants

      t.timestamps
    end
  end
end
