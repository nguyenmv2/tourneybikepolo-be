# frozen_string_literal: true

class Timer < ApplicationRecord
  STATUSES = %w(pending in_progress paused expired canceled).freeze
  enum status: Hash[STATUSES.zip(STATUSES)].symbolize_keys

  belongs_to :match, dependent: :destroy

  delegate :duration, to: :match

  def start
    jid = TimerWorker.perform_in(expires_at, id)
    update(jid: jid, expires_at: duration.seconds.from_now, status: "in_progress")
  end

  def pause
    paused_with = (expires_at - Time.now)
    update(paused_with: paused_with, expires_at: nil, status: "paused")
  end

  def resume
    expires_at = (Time.now + paused_with)
    jid = TimerWorker.perform_in(expires_at, id)
    update(paused_with: nil, expires_at: expires_at, jid: jid, status: "in_progress")
  end

  def stop
    update(paused_with: nil, expires_at: Time.now, status: "canceled", jid: nil)
  end

  def truly_expired?
    in_progress? && expires_at <= Time.now
  end
end
