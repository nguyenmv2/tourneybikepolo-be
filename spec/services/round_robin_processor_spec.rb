# frozen_string_literal: true

require "rails_helper"

describe RoundRobinProcessor do
  describe "#generate_bracket" do
    context "when there is an even number of teams" do
      let(:tournament) { build(:tournament_with_teams, team_count: 4) }
      let(:processor)  { RoundRobinProcessor.new(tournament.teams) }

      subject { processor.generate_bracket }

      it "generates the expected amount of rounds" do
        round_count = subject.keys.count

        expect(round_count).to eq(3)
      end
    end
  end
end
