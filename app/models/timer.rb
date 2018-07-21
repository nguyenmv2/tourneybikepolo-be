# frozen_string_literal: true

class Timer < ApplicationRecord
  enum status: Hash[TimerStatus::STATUSES.zip(TimerStatus::STATUSES)]

  belongs_to :match, dependent: :destroy

  validates :duration, presence: true

  def status
    @status ||= TimerStatus.new(read_attribute(:status))
  end
end
