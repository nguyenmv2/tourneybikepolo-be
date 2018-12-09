# frozen_string_literal: true

require "rails_helper"

describe RoundRobin do
  describe ".schedule" do
    context "when there is an even number of teams" do
      let!(:teams) { build_stubbed_list(:team, 4) }
      let!(:team_ids) { teams.pluck(:id) }
      subject! { RoundRobin.schedule(team_ids: team_ids) }

      it "should build the expected number of rounds in each group" do
        number_of_rounds = subject.select(&:present?).size

        expect(number_of_rounds).to eq(teams.size - 1)
      end

      it "should include each team only once in every round" do
        team_ids.each do |team_id|
          first_round = subject.first.find { |game| game.include?(team_id) }
          second_round = subject.second.find { |game| game.include?(team_id) }
          third_round = subject.third.find { |game| game.include?(team_id) }

          expect(first_round).to include(team_id)
          expect(first_round.sort).not_to eq(second_round.sort)
          expect(first_round.sort).not_to eq(third_round.sort)

          expect(second_round).to include(team_id)
          expect(second_round.sort).not_to eq(first_round.sort)
          expect(second_round.sort).not_to eq(third_round.sort)

          expect(third_round).to include(team_id)
          expect(third_round.sort).not_to eq(first_round.sort)
          expect(third_round.sort).not_to eq(second_round.sort)
        end
      end
    end

    context "when there are an odd number of teams" do
      let!(:teams) { build_stubbed_list(:team, 3) }
      let!(:team_ids) { teams.pluck(:id) }
      subject! { RoundRobin.schedule(team_ids: team_ids) }

      it "should build the expected number of rounds in each group" do
        number_of_rounds = subject.select(&:present?).size

        expect(number_of_rounds).to eq(teams.size)
      end

      it "should include each team only once in every round" do
        (team_ids << 0).each do |team_id|
          first_round = subject.first.find { |game| game.include?(team_id) }
          second_round = subject.second.find { |game| game.include?(team_id) }
          third_round = subject.third.find { |game| game.include?(team_id) }

          expect(first_round).to include(team_id)
          expect(first_round.sort).not_to eq(second_round.sort)
          expect(first_round.sort).not_to eq(third_round.sort)

          expect(second_round).to include(team_id)
          expect(second_round.sort).not_to eq(first_round.sort)
          expect(second_round.sort).not_to eq(third_round.sort)

          expect(third_round).to include(team_id)
          expect(third_round.sort).not_to eq(first_round.sort)
          expect(third_round.sort).not_to eq(second_round.sort)
        end
      end
    end
  end
end
