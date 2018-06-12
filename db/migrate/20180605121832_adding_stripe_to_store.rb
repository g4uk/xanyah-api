# frozen_string_literal: true

class AddingStripeToStore < ActiveRecord::Migration[5.1]
  def change
    add_column :stores, :gateway_customer_id, :string

    Store.all.each do |store|
      stripe_customer = Stripe::Customer.create(
        description: store.name,
        email:       store.owners.first&.email
      )
      store.update(gateway_customer_id: stripe_customer.id)
    end
  end
end
