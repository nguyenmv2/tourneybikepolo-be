# frozen_string_literal: true

class Registration < ApplicationRecord
  belongs_to :team
  belongs_to :user
  belongs_to :enrollment

  enum status: { failed: 0, succeeded: 1, pending: 2 }

  # Public: Queriesfor a specific registration record based on the passed arguments.
  #
  # user - A User record object.
  # team - A Team record object.
  # tournament- A Tournament record object.
  #
  # Examples
  #
  #   hsh = { user: User.find(1),
  #           team: Team.find(1),
  #           tournament: Tournament.find(1) }
  #
  #   Registration.fetch(hsh)
  #   # => Registration
  #
  # Returns the associated Registration record object.
  def self.fetch(user:, team:, tournament:)
    enrollment = tournament.enrollments.find_by(team_id: team.id)
    find_by(user_id: user.id, team_id: team.id, enrollment_id: enrollment.id)
  end
end
