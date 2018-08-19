# frozen_string_literal: true

class Round < ApplicationRecord
  TYPES = %w(round_robin swiss_rounds single_elimination double_elimination).freeze
  enum format_type: Hash[TYPES.zip(TYPES)].symbolize_keys

  belongs_to :tournament

  validates :format_type, presence: true

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
