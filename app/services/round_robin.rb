# frozen_string_literal: true

module RoundRobin
  def self.schedule(team_ids)
    team_ids.push nil if team_ids.size.odd?

    generator = Generator.new(team_ids)
    generator.build
  end
end
