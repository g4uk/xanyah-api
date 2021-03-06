# frozen_string_literal: true

class CreateProviders < ActiveRecord::Migration[5.1]
  def change
    create_table :providers, id: :uuid do |t|
      t.string :name
      t.string :notes
      t.belongs_to :store, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
