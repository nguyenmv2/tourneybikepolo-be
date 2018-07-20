# frozen_string_literal: true

class CreateTimers < ActiveRecord::Migration[5.2]
  def change
    create_table :timers do |t|
      t.integer :duration, null: false
      t.string :jid
      t.datetime :paused_with
      t.datetime :expires_at
      t.references :match, foreign_key: true, index: true

      t.timestamps
    end
  end
end
