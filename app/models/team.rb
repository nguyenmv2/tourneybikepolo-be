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
end
