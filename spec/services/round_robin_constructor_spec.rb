# frozen_string_literal: true

require "rails_helper"

describe RoundRobinConstructor do
  let!(:tournament) { create(:tournament) }
  let!(:teams) { create_list(:team, 8) }
  let!(:round_robin) { described_class.new(teams, tournament) }

  subject { round_robin.build }

  describe "#build" do
    it "should return a RoundRobin object" do
      expect(subject.class).to eq(RoundRobin)
    end

    it "should have an matches array attribute on the returned object" do
      expect(subject.matches.class).to eq(Array)
      expect(subject.matches).not_to be_empty
    end

    context "when there are an even number of teams" do
      it "should create the expected number of matches" do
        expect { subject }.to change { Match.count }.from(0).to(28)
        expect(subject.match_count).to eq(28)
      end

      it "should create the correct amount of matches for each team" do
        expected_match_count = teams.size - 1

        teams.each do |team|
          actual_match_count = subject.matches.select { |m| m.teams.include?(team) }.size

          expect(actual_match_count).to eq(expected_match_count)
        end
      end
    end

    context "when there are an odd number of teams" do
      let!(:teams) { create_list(:team, 7) }

      it "should create the expected number of matches" do
        expect { subject }.to change { Match.count }.from(0).to(28)
        expect(subject.match_count).to eq(28)
      end

      it "should create the correct amount of matches for each team" do
        expected_match_count = teams.size

        teams.each do |team|
          actual_match_count = subject.matches.select { |m| m.teams.include?(team) }.size

          expect(actual_match_count).to eq(expected_match_count)
        end
      end

      it "should give each team a bye" do
        bye_matches = teams.map do |team|
          subject.matches.select do |m|
            m.teams.include?(team) &&
              m.teams.flat_map(&:description).include?("Bye Team")
          end
        end

        expect(bye_matches.size).to eq(8)
      end
    end
  end
end
