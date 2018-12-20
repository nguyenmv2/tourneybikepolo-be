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
      create_first_match
      create_later_matches
      teams.rotate!
    end

    matches
  end

  private

  def create_first_match
    matches << create_match(
      teams.first, pivot
    )
  end

  def create_later_matches
    (1...(team_count / 2)).each do |i|
      matches << create_match(teams[i], teams[match_count - i])
    end
  end

  attr_reader :teams, :pivot, :tournament, :team_count, :match_count
end
