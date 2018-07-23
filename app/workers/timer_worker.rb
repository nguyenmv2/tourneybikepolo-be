# frozen_string_literal: true

class TimerWorker
  include Sidekiq::Worker

  def perform(id)
    timer = Timer.find(id)
    timer.update(status: "expired")
  end
end
