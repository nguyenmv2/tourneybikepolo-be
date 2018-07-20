# frozen_string_literal: true

class TimerStatus
  STATUSES = %w(pending in_progress paused expired canceled).freeze

  def initialize(status)
    @status = status
  end
end
