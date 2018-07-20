# frozen_string_literal: true

class Timer < ApplicationRecord
  enum status: Hash[TimerStatus::STATUSES.zip(TimerStatus::STATUSES)]

  def status
    @status ||= TimerStatus.new(read_attribute(:status))
  end
end
