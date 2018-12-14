# frozen_string_literal: true

class RoundRobinConstructor
  def initialize(teams, tournament)
    @teams = teams
    @tournament = tournament
    @round_robin = RoundRobin.new
  end

  def build
    create_bye if teams.size.odd?
    team_count = teams.size
    pivot = teams.pop

    generate_matches(team_count, pivot)
  end

  private

  attr_reader :teams, :tournament, :round_robin

  def generate_matches(team_count, pivot)
    match_count = team_count - 1
    match_count.times.each do
      teams.rotate!
      create_match(teams.first, pivot)
      (1...(team_count / 2)).each do |i|
        create_match(teams[i], teams[match_count - i])
      end
    end

    teams.push(pivot) unless pivot.nil?
    round_robin
  end

  def create_bye
    bye_team = tournament.teams.create!(
      name: "Instant Mix",
      description: "Bye Team"
    )
    teams.push(bye_team)
  end

  def create_match(team_one, team_two)
    match = tournament.matches.create!(team_one: team_one, team_two: team_two)
    round_robin.matches << match
  end
end

RoundRobin = Struct.new(:matches) do
  def initialize(matches=[])
    super
  end

  def match_count
    matches.size
  end
end
