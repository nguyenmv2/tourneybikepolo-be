# frozen_string_literal: true

class Team < ApplicationRecord
  has_many :rosters
  has_many :players, through: :rosters, dependent: :destroy
  has_many :enrollments
  has_many :tournaments, through: :enrollments
  has_many :registrations
end
