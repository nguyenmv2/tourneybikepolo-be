# frozen_string_literal: true

class Match < ApplicationRecord
  include Timeable
  belongs_to :tournament
  belongs_to :team_one, class_name: "Team", foreign_key: "team_one_id"
  belongs_to :team_two, class_name: "Team", foreign_key: "team_two_id"
  has_one :timer, dependent: :destroy

  def teams
    Team.where(id: [team_one_id, team_two_id])
  end

  def score
    Hash[teams.map(&:name).zip([team_one_score, team_two_score])]
  end

  def increment_score(team)
    update_score(team.id, "+")
  end

  def decrement_score(team)
    update_score(team.id, "-")
  end

  delegate :start, :pause, :resume, :stop, to: :timer

  private

  def update_score(team_id, adjustment)
    if team_one_id == team_id
      update(team_one_score: team_one_score.send(adjustment.to_sym, 1))
    elsif team_two_id == team_id
      update(team_two_score: team_two_score.send(adjustment.to_sym, 1))
    end
  end
end
