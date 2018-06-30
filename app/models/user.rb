# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :tournament_staffs
  has_many :tournaments, through: :tournament_staffs
  has_many :rosters, foreign_key: "player_id"
  has_many :teams, through: :rosters
  has_many :registrations

  validates :email, presence: true, uniqueness: true

  def payment_metadata
    { user_id: id, first: first, last: last, phone: phone }
  end
end
