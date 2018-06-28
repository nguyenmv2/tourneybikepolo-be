class Roster < ApplicationRecord
  belongs_to :player, class_name: "User", foreign_key: "player_id", required: true
  belongs_to :team, counter_cache: :player_count
end
