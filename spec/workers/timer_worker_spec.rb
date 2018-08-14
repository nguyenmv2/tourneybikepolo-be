# frozen_string_literal: true

require "rails_helper"
RSpec.describe TimerWorker, type: :worker do
  subject { create(:match, duration: 2.seconds.to_i).timer }

  it "adds the worker to the queue" do
    expect { TimerWorker.perform_in(subject.id) }
      .to change(TimerWorker.jobs, :size).by(1)
  end

  context "when timer is expired" do
    it "updates the timer status" do
      allow_any_instance_of(Timer).to receive(:truly_expired?).and_return(true)

      Sidekiq::Testing.inline! do
        expect { TimerWorker.perform_async(subject.id) }
          .to change { subject.reload.status }.to("expired")
      end
    end
  end

  context "when timer is not expired" do
    it "does nothing" do
      allow_any_instance_of(Timer).to receive(:truly_expired?).and_return(false)

      Sidekiq::Testing.inline! do
        expect { TimerWorker.perform_async(subject.id) }
          .to_not change { subject.reload.status }
      end
    end
  end
end
