# frozen_string_literal: true

require "rails_helper"

describe RoundRobin do
  let!(:tournament) { create(:tournament) }
  let!(:teams) { create_list(:team, 8) }

  subject { described_class.new(teams, tournament) }

  describe "#build" do
    context "when there are an even number of teams" do
      it "should create the expected number of matches" do
        expect { subject.build }.to change { subject.matches.size }.from(0).to(28)
      end

      it "should create the correct amount of matches for each team" do
        expected_match_count = teams.size - 1
        all_matches = subject.build

        teams.each do |team|
          actual_match_count = all_matches.select { |m| m.teams.include?(team) }.size

          expect(actual_match_count).to eq(expected_match_count)
        end
      end
    end

    context "when there are an odd number of teams" do
      let!(:teams) { create_list(:team, 7) }

      it "should give each team a bye" do
        subject.build

        teams.each do
          matches_with_bye_team = subject.matches.select do |m|
            m.teams.pluck(:name).include?("Instant Mix")
          end

          expect(matches_with_bye_team.size).to eq(teams.size)
        end
      end

      it "should create the expected number of matches" do
        expect { subject.build }.to change { subject.matches.size }.from(0).to(28)
      end

      it "should create the correct amount of matches for each team" do
        expected_match_count = teams.size
        all_matches = subject.build

        teams.each do |team|
          actual_match_count = all_matches.select { |m| m.teams.include?(team) }.size

          expect(actual_match_count).to eq(expected_match_count)
        end
      end
    end
  end
end
