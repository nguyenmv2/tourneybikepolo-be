# frozen_string_literal: true

class Tournament < ApplicationRecord
  has_many :tournament_staffs
  has_many :users, through: :tournament_staffs
  has_many :enrollments
  has_many :teams, through: :enrollments

  monetize :price_cents, as: "fee"
end
