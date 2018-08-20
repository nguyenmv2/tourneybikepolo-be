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

      it "pairs team A with every other team once" do
        expect(subject.values[0][0]).to eq(["A", "F"])
        expect(subject.values[1][0]).to eq(["A", "E"])
        expect(subject.values[2][0]).to eq(["A", "D"])
        expect(subject.values[3][0]).to eq(["A", "C"])
        expect(subject.values[4][0]).to eq(["A", "B"])
      end
    end

    context "when there is an odd number of teams" do
      let(:tournament) { build(:tournament_with_teams, team_count: 3) }
      let(:processor)  { RoundRobinProcessor.new(tournament.teams) }
      let(:filler_team) { build_stubbed(:team) }

      before do
        allow(Team).to receive(:add_filler_team)
          .and_return(tournament.teams << filler_team)
      end

      subject { processor.generate_bracket }

      it "generates the correct amount of rounds" do
        number_of_rounds = subject.keys.count

        expect(number_of_rounds).to eq(3)
      end

      it "pairs first team with every other team and filler team once" do
        team_one, team_two, team_three, filler_team = tournament.teams

        expect(subject.values[0][0]).to eq([team_one, filler_team])
        expect(subject.values[1][0]).to eq([team_one, team_three])
        expect(subject.values[2][0]).to eq([team_one, team_two])
      end
    end
  end
end
