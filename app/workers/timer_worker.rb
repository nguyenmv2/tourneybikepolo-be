# frozen_string_literal: true

class TimerWorker
  include Sidekiq::Worker

  # Public: Handles the countdown in the background.
  #
  # id - A Timer record id.
  #
  # Examples
  #
  #   team_one, team_two = Team.last(2)
  #   match = Match.create(team_one_id: team_one.id, team_two_id: team_two.id, duration: 2.seconds.to_i)
  #   timer = match.timer
  #   TimerWorker.perform_async(timer.id)
  #   # => true
  #
  # Returns a boolean or nil depending on if the timer is expired.
  def perform(id)
    timer = Timer.find(id)

    return unless timer.truly_expired?
    timer.update(status: "expired")
  end
end
