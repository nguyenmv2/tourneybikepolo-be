# frozen_string_literal: true

class Match < ApplicationRecord
  belongs_to :tournament
  belongs_to :team_one, class_name: "Team", foreign_key: "team_one_id"
  belongs_to :team_two, class_name: "Team", foreign_key: "team_two_id"
  has_one :timer, dependent: :destroy

  after_create :add_timer
  after_update :set_duration, if: :duration_changed?

  validates :duration, presence: true

  # Public: Queries for the two team associated with a match.
  #
  # Examples
  #
  #   team_one, team_two = Team.last(2)
  #   match = Match.create(team_one_id: team_one.id, team_two_id: team_two.id)
  #   match.teams
  #   # => Team::ActiveRecord_Relation
  #
  # Returns a collection containing two associated Team record objects.
  def teams
    Team.where(id: [team_one_id, team_two_id])
  end

  # Public: Builds a hash containing the team's current score.
  #
  # Examples
  #
  #   team_one, team_two = Team.last(2)
  #   match = Match.create(team_one_id: team_one.id, team_two_id: team_two.id)
  #   match.score
  #   # => {"team_one_name"=>1, "team_two_name"=>3}
  #
  # Returns a hash containing each team's name and score.
  def score
    Hash[teams.map(&:name).zip([team_one_score, team_two_score])]
  end

  # Public: Adds one point to a team's score.
  #
  # team - A Team record object.
  #
  # Examples
  #
  #   team_one, team_two = Team.last(2)
  #   match = Match.create(team_one_id: team_one.id, team_two_id: team_two.id)
  #   match.increment_score(team_one)
  #   # => true
  #
  # Returns true when the match score is updated.
  def increment_score(team)
    update_score(team.id, "+")
  end

  # Public: Removes one point from a team's score.
  #
  # team - A Team record object.
  #
  # Examples
  #
  #   team_one, team_two = Team.last(2)
  #   match = Match.create(team_one_id: team_one.id, team_two_id: team_two.id)
  #   match.decrement_score(team_one)
  #   # => true
  #
  # Returns true when the match score is updated.
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

  def add_timer
    Timer.create(match_id: id, expires_at: duration.seconds.from_now)
  end

  def set_duration
    timer.update(expires_at: duration.seconds.from_now)
  end
end
