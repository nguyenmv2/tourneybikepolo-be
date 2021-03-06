# frozen_string_literal: true

class Roster < ApplicationRecord
  belongs_to :player, class_name: "User", foreign_key: "player_id", required: true
  belongs_to :team
end
