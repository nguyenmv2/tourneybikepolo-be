# frozen_string_literal: true

class SetDefaultValueForPlayerCount < ActiveRecord::Migration[5.2]
  def change
    change_column_default :teams, :player_count, 0
  end
end
