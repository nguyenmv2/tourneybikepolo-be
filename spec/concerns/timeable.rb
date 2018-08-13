# frozen_string_literal: true

shared_examples_for "timeable" do
  let(:model) { described_class }

  describe "#add_timer" do
    it "creates an associated timer record" do
      expect { create(model.to_s.underscore.to_sym) }.to change { Timer.count }.by(1)
    end
  end

  describe "#set_duration" do
    it "updates the associated timer's expires_at column" do
      obj = create(model.to_s.underscore.to_sym)
      allow(obj).to receive(:duration_changed?).and_return(true)

      freeze_time do
        expect { obj.update!(duration: 12.seconds.to_i) }
          .to change { obj.timer.expires_at }.to(12.seconds.from_now)
      end
    end
  end
end
