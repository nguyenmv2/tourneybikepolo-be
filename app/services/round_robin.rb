# frozen_string_literal: true

module RoundRobin
  def self.schedule(team_ids)
    team_ids.push nil if team_ids.size.odd?

    s = Schedule.new(team_ids)
    s.build
  end

  class Schedule
    def initialize(team_ids)
      @team_ids = team_ids
      @team_count = team_ids.size
      @pivot = team_ids.pop
      @round_count = (team_count - 1)
    end

    def build
      round_count.times.map do
        team_ids.rotate!
        construct_round
      end
    end

    private

    attr_reader :team_ids, :team_count, :pivot, :round_count

    def construct_round
      [[team_ids.first, pivot]] + round
    end

    def round
      (1...(team_count / 2)).map do |i|
        [team_ids[i], team_ids[team_count - 1 - i]]
      end
    end
  end
end
