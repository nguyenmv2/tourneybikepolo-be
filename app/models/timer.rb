# frozen_string_literal: true

class Timer < ApplicationRecord
  enum status: Hash[TimerStatus::STATUSES.zip(TimerStatus::STATUSES)]

  belongs_to :match, dependent: :destroy

  validates :duration, presence: true

  def status
    @status ||= TimerStatus.new(read_attribute(:status))
  end

  def start
    jid = TimerWorker.perform_in(expires_at, id)
    update(jid: jid, status: "in_progress")
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
end
