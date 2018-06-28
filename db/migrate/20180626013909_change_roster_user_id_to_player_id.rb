# frozen_string_literal: true

class ChangeRosterUserIdToPlayerId < ActiveRecord::Migration[5.2]
  def change
    rename_column :rosters, :user_id, :player_id
  end
end
