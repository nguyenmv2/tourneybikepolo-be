# frozen_string_literal: true

class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.integer :team_one_id, foreign_key: true, null: false, index: true
      t.integer :team_two_id, foreign_key: true, null: false, index: true
      t.integer :team_one_score, default: 0, null: false
      t.integer :team_two_score, default: 0, null: false
      t.references :tournament, foreign_key: true, null: false

      t.timestamps
    end
  end
end
