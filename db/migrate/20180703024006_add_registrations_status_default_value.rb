# frozen_string_literal: true

class AddRegistrationsStatusDefaultValue < ActiveRecord::Migration[5.2]
  def change
    change_column_default :registrations, :status, 2
  end
end
