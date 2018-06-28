# frozen_string_literal: true

class CreateEnrollments < ActiveRecord::Migration[5.2]
  def change
    create_table :enrollments do |t|
      t.references :team, foreign_key: true
      t.references :tournament, foreign_key: true

      t.timestamps
    end
  end
end
