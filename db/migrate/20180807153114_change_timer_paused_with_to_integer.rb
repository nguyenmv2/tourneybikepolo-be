# frozen_string_literal: true

class ChangeTimerPausedWithToInteger < ActiveRecord::Migration[5.2]
  def up
    remove_column :timers, :paused_with
    add_column :timers, :paused_with, :float
  end

  def down
    remove_column :timers, :paused_with
    add_column :timers, :paused_with, :datetime
  end
end
