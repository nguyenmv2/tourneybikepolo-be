# frozen_string_literal: true

class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :name
      t.text :description
      t.string :logo
      t.integer :player_count

      t.timestamps
    end
  end
end
