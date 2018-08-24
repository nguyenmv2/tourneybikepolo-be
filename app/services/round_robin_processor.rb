# frozen_string_literal: true

class RoundRobinProcessor
  attr_accessor :teams
  attr_reader :rounds

  # Public: Initialize the processor object.
  #
  # teams - A collection of teams.
  def initialize(teams)
    @rounds = {}
    @teams = teams
  end

  # Public: Generates the bracket for all rounds.
  #
  # Examples
  #
  #   processor = RoundRobinProcessor.new(["A", "B", "C", "D", "E", "F"])
  #   processor.generate_bracket
  #   # => {1=>[["A", "F"], ["B", "E"], ["C", "D"]], ... ]}
  #
  # Returns a hash containing each round and it's matches.
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
