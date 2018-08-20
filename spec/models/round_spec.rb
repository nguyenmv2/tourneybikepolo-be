# frozen_string_literal: true

require "rails_helper"

RSpec.describe Round, type: :model do
  it { should belong_to(:tournament) }
  it { should validate_presence_of(:format_type) }

  it do
    should define_enum_for(:format_type).with(
      round_robin: "round_robin",
      swiss_rounds: "swiss_rounds",
      single_elimination: "single_elimination",
      double_elimination: "double_elimination"
    )
  end

  describe "generate_bracket" do
    context "when format_type is round_robin" do
      it "proxys the method to the round robin processor" do
        round = build_stubbed(:round, format_type: "round_robin")
        expect_any_instance_of(RoundRobinProcessor).to receive(:generate_bracket)

        round.generate_bracket
      end
    end
  end
end
