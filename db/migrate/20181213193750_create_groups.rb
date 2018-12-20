# frozen_string_literal: true

class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string :name, null: false
      t.references :tournament, foreign_key: true, index: true, null: false

      t.timestamps
    end
  end
end