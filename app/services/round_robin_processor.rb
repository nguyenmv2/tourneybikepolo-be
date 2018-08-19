# frozen_string_literal: true

class RoundRobinProcessor
  attr_accessor :teams
  attr_reader :rounds

  def initialize(teams)
    @rounds = {}
    @teams = teams
  end

  def generate_bracket
    teams.add_filler_team if teams.size.odd?
    round_count = teams.size - 1
    matches_per_round = teams.size / 2

    round_count.times do |index|
      rounds[index + 1] = []

      matches_per_round.times do |match_index|
        rounds[index + 1] << [teams[match_index], teams.reverse[match_index]]
      end

      self.teams = [teams[0]] + teams[1..-1].rotate(-1)
    end

    rounds
  end
end
