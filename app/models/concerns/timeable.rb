# frozen_string_literal: true

module Timeable
  extend ActiveSupport::Concern

  included do
    after_create :add_timer
    after_update :set_duration
  end

  def add_timer
    Timer.create(match_id: id)
  end

  def set_duration
    return unless duration_changed?
    timer.update(expires_at: duration.seconds.from_now)
  end
end
