# frozen_string_literal: true

require "rails_helper"

RSpec.describe Timer, type: :model do
  it { should belong_to(:match).dependent(:destroy) }

  it do
    should define_enum_for(:status).with(
      pending: "pending",
      in_progress: "in_progress",
      paused: "paused",
      expired: "expired",
      canceled: "canceled"
    )
  end

  subject { create(:match, duration: 5.seconds.to_i).timer }

  describe "#duration" do
    it "should return the associated match duration" do
      expect(subject.duration).to eq(5)
    end
  end

  describe "#start" do
    it "fires a worker and updates the timer status and jid columns" do
      freeze_time do
        expect { subject.start }.to change { TimerWorker.jobs.size }.by(1)
          .and change { subject.status }.from("pending").to("in_progress")
          .and change { subject.jid }
      end
    end
  end

  describe "#pause" do
    it "updates the timer status, paused_with, and expires_at columns" do
      freeze_time do
        expect { subject.pause }.to change { subject.paused_with }.to(subject.expires_at - Time.now)
          .and change { subject.expires_at }.to(nil)
          .and change { subject.status }.from("pending").to("paused")
      end
    end
  end

  describe "#resume" do
    it "fires a new worker and updates the timer paused_with, expires_at, jid and status columns" do
      freeze_time do
        subject.update(paused_with: 8.0)
        expected = (Time.now + subject.paused_with)

        expect { subject.resume }.to change { subject.expires_at }.to(expected)
          .and change { subject.paused_with }.to(nil)
          .and change { subject.status }.to("in_progress")
          .and change { subject.jid }
      end
    end
  end

  describe "#stop" do
    it "updates the timer timer paused_with, expires_at and status columns" do
      freeze_time do
        expect { subject.stop }.to change { subject.expires_at }.to(Time.now)
          .and change { subject.status }.to("canceled")
        expect(subject.paused_with).to be_nil
        expect(subject.jid).to be_nil
      end
    end
  end
end
