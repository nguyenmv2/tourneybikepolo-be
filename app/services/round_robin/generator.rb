# frozen_string_literal: true

module RoundRobin
  class Generator
    def initialize(team_ids, team_count, pivot)
      @team_ids = team_ids
      @team_count = team_count
      @pivot = pivot
    end

    def build
      Array.new(round_count) { construct_round.build }
    end

    private

    attr_reader :team_ids, :team_count, :pivot

    def construct_round
      RoundConstructor.new(
        team_ids.rotate!,
        team_count,
        pivot,
        round_count
      )
    end

    def round_count
      team_count - 1
    end
  end
end
