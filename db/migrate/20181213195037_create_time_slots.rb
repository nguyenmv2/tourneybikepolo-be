# frozen_string_literal: true

class CreateTimeSlots < ActiveRecord::Migration[5.2]
  def change
    create_table :time_slots do |t|
      t.datetime :time
      t.references :tournament, foreign_key: true

      t.timestamps
    end
  end
end
