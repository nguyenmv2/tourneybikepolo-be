# frozen_string_literal: true

class AddStatusToTimes < ActiveRecord::Migration[5.2]
  def up
    execute <<-SQL
      CREATE TYPE timers_status AS ENUM ('pending', 'in_progress', 'paused', 'expired', 'canceled');
    SQL
    add_column :timers, :status, :timers_status, default: "pending"
    add_index :timers, :status
  end

  def down
    remove_column :timers, :status
    execute <<-SQL
      DROP TYPE timers_status;
    SQL
  end
end
