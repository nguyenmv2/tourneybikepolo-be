# frozen_string_literal: true

class Team < ApplicationRecord
  has_many :rosters
  has_many :players, through: :rosters
  has_many :enrollments
  has_many :tournaments, through: :enrollments
  has_many :registrations
  has_many :home_matches, class_name: "Match", foreign_key: "team_one_id"
  has_many :away_matches, class_name: "Match", foreign_key: "team_two_id"

  validates :name, presence: true

  # Public: Helper method to fetch associated match records.
  #
  # Examples
  #
  #   team = Team.create(...)
  #   team.matches
  #   # => Match::ActiveRecord_Relation
  #
  # Returns a collection containing the associated Team record objects.
  def matches
    Match.where("team_one_id = ? OR team_two_id = ?", self.id, self.id)
  end

  # Public: Adds an additional team to even out the tournament team count number.
  #
  # Examples
  #
  #   tournament = Tournament.create(...)
  #   tournament.teams.add_filler_team
  #   # => Team::ActiveRecord_Relation
  #
  # Returns a collection of Team objects with the newly created "Instant Mix" team.
  def self.add_filler_team
    all.create(name: "Instant Mix")
  end
end
