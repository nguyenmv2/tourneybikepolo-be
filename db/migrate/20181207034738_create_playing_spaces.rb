# frozen_string_literal: true

class CreatePlayingSpaces < ActiveRecord::Migration[5.2]
  def change
    create_table :playing_spaces do |t|
      t.string :name
      t.belongs_to :tournament, index: true

      t.timestamps
    end
  end
end
