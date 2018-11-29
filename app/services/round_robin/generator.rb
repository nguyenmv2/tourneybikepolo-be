# frozen_string_literal: true

module RoundRobin
  class Generator
    def initialize(team_ids)
      @team_ids = team_ids
      @team_count = team_ids.size
      @pivot = team_ids.pop
      @round_count = (team_count - 1)
    end

    def build
      round_count.times.map { construct_round }
    end

    private

    attr_reader :team_ids, :team_count, :pivot, :round_count

    def construct_round
      team_ids.rotate!
      [first_game, other_games]
    end

    def first_game
      [team_ids.first, pivot]
    end

    def other_games
      (1...(team_count / 2)).map do |i|
        [team_ids[i], team_ids[team_count - 1 - i]]
      end.flatten
    end
  end
end
