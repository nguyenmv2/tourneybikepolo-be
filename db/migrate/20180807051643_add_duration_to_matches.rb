# frozen_string_literal: true

class AddDurationToMatches < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :duration, :integer, default: 720, null: false
  end
end
