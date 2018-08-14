# frozen_string_literal: true

class RemoveDurationFromTimers < ActiveRecord::Migration[5.2]
  def change
    remove_column :timers, :duration
  end
end
