# frozen_string_literal: true

class CreateTournamentStaffs < ActiveRecord::Migration[5.2]
  def change
    create_table :tournament_staffs do |t|
      t.references :user, foreign_key: true
      t.references :tournament, foreign_key: true
      t.integer :role

      t.timestamps
    end
  end
end
