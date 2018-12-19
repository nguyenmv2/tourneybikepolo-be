# frozen_string_literal: true

class RoundRobin < RoundBase
  attr_reader :matches

  def initialize(teams, tournament)
    @tournament = tournament
    @teams = teams.size.odd? ? teams << create_bye : teams
    @team_count = teams.size
    @match_count = team_count - 1
    @pivot = teams.pop
    @matches = []
  end

  def build
    match_count.times.each do
      matches << create_match(teams.first, pivot)

      (1...(team_count / 2)).each do |i|
        matches << create_match(teams[i], teams[match_count - i])
      end

      teams.rotate!
    end

    matches
  end

  private

  attr_reader :teams, :pivot, :tournament, :team_count, :match_count
end
