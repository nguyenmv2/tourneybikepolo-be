# frozen_string_literal: true

require "rails_helper"

describe RoundRobinProcessor do
  describe "#generate_bracket" do
    context "when there is an even number of teams" do
      let(:processor)  { RoundRobinProcessor.new(["A", "B", "C", "D", "E", "F"]) }

      subject { processor.generate_bracket }

      it "generates the correct amount of rounds" do
        number_of_rounds = subject.keys.count

        expect(number_of_rounds).to eq(5)
      end
    end
  end
end
