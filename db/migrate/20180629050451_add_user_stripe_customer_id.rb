# frozen_string_literal: true

class AddUserStripeCustomerId < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :stripe_customer_id, :string, limit: 51, null: true
  end
end
