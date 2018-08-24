# frozen_string_literal: true

class Round < ApplicationRecord
  TYPES = %w(round_robin swiss_rounds single_elimination double_elimination).freeze
  enum format_type: Hash[TYPES.zip(TYPES)].symbolize_keys

  belongs_to :tournament

  validates :format_type, presence: true

  # Public: Generates the bracket for all rounds.
  #
  # Examples
  #
  #   tournament = Tournament.create(..)
  #   round = tournament.rounds.create(..)
  #   round.generate_bracket
  #   # => {1=>[["A", "F"], ["B", "E"], ["C", "D"]], ... ]}
  #
  # Returns a hash containing each round and it's matches.
  def generate_bracket
    processor.generate_bracket
  end

  private

  def processor
    case format_type
    when "round_robin"
      RoundRobinProcessor.new(tournament.teams)
    when "swiss_rounds"
      # SwissRoundsProcessor.new(tournament.teams)
    when "single_elimination"
      # SingleEliminationProcessor.new(tournament.teams)
    when "double_elimination"
      # DoubleEliminationProcessor.new(tournament.teams)
    end
  end
end
