# frozen_string_literal: true

include ActionView::Helpers::TextHelper

puts "Seeding for env '#{Rails.env}'"

# Seed Tournaments
tournament_count = 5.times do
  start_date = rand(2..5).weeks.from_now.next_week.advance(days: 5) # finds closest Saturday
  tournament = Tournament.create(
    name: Faker::Esport.event,
    start_date: start_date,
    end_date: start_date + 1.day,
    registration_start_date: start_date.next_week - 1.month,
    registration_end_date: start_date - 1.week
  )

  # Seed Teams
  8.times do
    team = tournament.teams.create(name: Faker::Team.name)

    # Seed Players
    5.times do
      player = team.players.create(
        first: Faker::Name.first_name,
        last: Faker::Name.last_name,
        email: Faker::Internet.safe_email,
        password: Faker::Internet.password(8)
      )

      # Seed Registration
      enrollment = tournament.enrollments.find_by(team_id: team.id)
      team.registrations.create(enrollment_id: enrollment.id, user_id: player.id, status: "succeeded")
    end
  end

  # Generate Round Robin
  teams = Team.all.to_a
  teams.push nil if teams.size.odd?
  n = teams.size
  pivot = teams.pop
  games = (n - 1).times.map do
    teams.rotate!
    [[teams.first, pivot]] + (1...(n / 2)).flat_map { |j| [teams[j], teams[n - 1 - j]] }
  end
  teams.push pivot unless pivot.nil?

  # Seed Matches
  games.count.times do |i|
    game = games[i]
    tournament.matches.create(team_one_id: game[1].id, team_two_id: game[2].id)
  end
end

# Output
new_tournaments = Tournament.last(tournament_count)
puts "Created #{pluralize(tournament_count, "Tournament")}"
puts "Created #{pluralize(new_tournaments.flat_map(&:teams).count, "Team")}"
puts "Created #{pluralize(new_tournaments.flat_map(&:teams).flat_map(&:players).count, "Player")}"
puts "Created #{pluralize(new_tournaments.flat_map(&:teams).flat_map(&:registrations).count, "Registration")}"
puts "Created #{pluralize(new_tournaments.flat_map(&:matches).count, "Match")}"
