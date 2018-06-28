class User < ApplicationRecord
  has_secure_password

  has_many :tournament_staffs
  has_many :tournaments, through: :tournament_staffs
  has_many :rosters, foreign_key: "player_id"
  has_many :teams, through: :rosters, dependent: :destroy
  has_many :registrations

  validates :email, presence: true, uniqueness: true
end
