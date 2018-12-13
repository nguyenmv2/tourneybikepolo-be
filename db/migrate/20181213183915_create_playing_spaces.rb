# frozen_string_literal: true

class CreatePlayingSpaces < ActiveRecord::Migration[5.2]
  def change
    create_table :playing_spaces do |t|
      t.string :name, null: false
      t.references :tournament, foreign_key: true, index: true, null: false

      t.timestamps
    end
  end
end
