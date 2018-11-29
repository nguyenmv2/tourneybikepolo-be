# frozen_string_literal: true

require "rails_helper"

describe RoundRobin do
  describe ".schedule" do
    context "when there is an even number of teams" do
      let(:teams) { build_stubbed_list(:team, 24) }
      let!(:team_ids) { teams.pluck(:id) }
      subject { RoundRobin.schedule(team_ids) }

      it "should build the expected number of rounds in each group" do
        expect(subject.size).to eq(23)
      end

      it "should pair every team with every other team once" do
        team_ids.each do |team_id|
          games = games_scheduled(subject, team_id)
          byes = byes_scheduled(subject)

          expect(games.size).to eq(23)
          expect(byes.size).to eq(23)
        end
      end
    end

    context "when there are an odd number of teams" do
      let!(:teams) { build_stubbed_list(:team, 23) }
      let!(:team_ids) { teams.pluck(:id) }
      subject { RoundRobin.schedule(team_ids) }

      it "should pair every team with every other team once with a bye round" do
        team_ids.each do |team_id|
          games = games_scheduled(subject, team_id)
          byes = byes_scheduled(subject)

          expect(games.size).to eq(23)
          expect(byes.size).to eq(23)
        end
      end
    end
  end
end
