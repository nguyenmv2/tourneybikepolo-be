# frozen_string_literal: true

class Timer < ApplicationRecord
  STATUSES = %w(pending in_progress paused expired canceled).freeze
  enum status: Hash[STATUSES.zip(STATUSES)].symbolize_keys

  belongs_to :match, dependent: :destroy

  delegate :duration, to: :match

  # Public: Starts the timer.
  #
  # Examples
  #
  #   team_one, team_two = Team.last(2)
  #   match = Match.create(team_one_id: team_one.id, team_two_id: team_two.id, duration: 10.seconds.to_i)
  #   timer = match.timer
  #   timer.start
  #   # => true
  #
  # Returns a boolean which indicates the result of #update.
  def start
    jid = TimerWorker.perform_in(expires_at, id)
    update(jid: jid, status: "in_progress")
  end

  # Public: Pauses the timer.
  #
  # Examples
  #
  #   team_one, team_two = Team.last(2)
  #   match = Match.create(team_one_id: team_one.id, team_two_id: team_two.id, duration: 10.seconds.to_i)
  #   timer = match.timer
  #   timer.pause
  #   # => true
  #
  # Returns a boolean which indicates the result of #update.
  def pause
    paused_with = (expires_at - Time.now)
    update(paused_with: paused_with, expires_at: nil, status: "paused")
  end

  # Public: Resumes the timer.
  #
  # Examples
  #
  #   team_one, team_two = Team.last(2)
  #   match = Match.create(team_one_id: team_one.id, team_two_id: team_two.id, duration: 10.seconds.to_i)
  #   timer = match.timer
  #   timer.resume
  #   # => true
  #
  # Returns a boolean which indicates the result of #update.
  def resume
    expires_at = (Time.now + paused_with)
    jid = TimerWorker.perform_in(expires_at, id)
    update(paused_with: nil, expires_at: expires_at, jid: jid, status: "in_progress")
  end

  # Public: Cancels the timer.
  #
  # Examples
  #
  #   team_one, team_two = Team.last(2)
  #   match = Match.create(team_one_id: team_one.id, team_two_id: team_two.id, duration: 10.seconds.to_i)
  #   timer = match.timer
  #   timer.stop
  #   # => true
  #
  # Returns a boolean which indicates the result of #update.
  def stop
    update(paused_with: nil, expires_at: Time.now, status: "canceled", jid: nil)
  end

  # Public: Determines if the timer is expired or not.
  #
  # Examples
  #
  #   team_one, team_two = Team.last(2)
  #   match = Match.create(team_one_id: team_one.id, team_two_id: team_two.id, duration: 2.seconds.to_i)
  #   timer = match.timer
  #   timer.start
  #   timer.truly_expired?
  #   # => false
  #   sleep(3)
  #   timer.truly_expired?
  #   # => true
  #
  # Returns a boolean.
  def truly_expired?
    in_progress? && expires_at <= Time.now
  end
end
