# frozen_string_literal: true

class Match < ApplicationRecord
  belongs_to :tournament
  belongs_to :team_one, class_name: "Team", foreign_key: "team_one_id"
  belongs_to :team_two, class_name: "Team", foreign_key: "team_two_id"

  def teams
    Team.where(id: [team_one_id, team_two_id])
  end

  def score
    Hash[teams.map(&:name).zip([team_one_score, team_two_score])]
  end
end
