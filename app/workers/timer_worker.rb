# frozen_string_literal: true

class TimerWorker
  include Sidekiq::Worker

  def perform(id)
    timer = Timer.find(id)

    return unless timer.truly_expired?
    timer.update(status: "expired")
  end
end
