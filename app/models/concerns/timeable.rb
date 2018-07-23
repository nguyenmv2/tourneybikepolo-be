# frozen_string_literal: true

module Timeable
  extend ActiveSupport::Concern

  included do
    after_create :add_timer
  end

  def add_timer
    Timer.create(match_id: id, duration: 12.minutes.to_i)
  end
end
