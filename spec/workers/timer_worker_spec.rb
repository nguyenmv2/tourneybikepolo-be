# frozen_string_literal: true

require "rails_helper"
RSpec.describe TimerWorker, type: :worker do
  describe "#peform_in" do
    it "adds the worker to the queue" do
      m = create(:match, duration: 2.seconds.to_i)

      expect { TimerWorker.perform_in(m.duration, m.timer.id) }
        .to change(TimerWorker.jobs, :size).by(1)
    end
  end
end
