# frozen_string_literal: true

module RoundRobin
  def self.schedule(team_ids)
    team_ids.push 0 if team_ids.size.odd?
    team_count = team_ids.size
    pivot = team_ids.pop

    generator = Generator.new(team_ids, team_count, pivot)
    generator.build
  end
end
