# frozen_string_literal: true

module RoundRobin
  def self.schedule(team_ids:, group_count: 1)
    group_count = (team_ids.size / group_count)

    # Array.new(group_count) do
      generator(team_ids).build
    # end
  end

  def self.generator(team_ids)
    team_ids.push(0) if team_ids.size.odd?

    args = {
      team_ids: team_ids,
      team_count: team_ids.size,
      pivot: team_ids.pop
    }

    Generator.new(**args)
  end
end
