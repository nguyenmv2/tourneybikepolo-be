# frozen_string_literal: true

module RoundRobin
  class RoundConstructor
    def initialize(team_ids, team_count, pivot, round_count)
      @team_ids = team_ids
      @team_count = team_count
      @pivot = pivot
      @round_count = round_count
    end

    def build
      [first_game, other_games]
    end

    private

    attr_reader :team_ids, :team_count, :pivot, :round_count

    def first_game
      [team_ids.first, pivot]
    end

    def other_games
      halfed_team_count.flat_map do |i|
        [team_ids[i], team_ids[round_count - i]]
      end
    end

    def halfed_team_count
      1...(team_count / 2)
    end
  end
end
