# frozen_string_literal: true

class RoundBase
  def create_match(team_one, team_two)
    tournament.matches.create!(
      team_one: team_one,
      team_two: team_two
    )
  end

  def create_bye
    tournament.teams.create!(
      name: "Instant Mix",
      description: "Bye Team"
    )
  end
end
