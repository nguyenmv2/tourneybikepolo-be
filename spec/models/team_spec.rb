# frozen_string_literal: true

require "rails_helper"

describe Team, type: :model do
  it { should have_many(:rosters) }
  it { should have_many(:players).through(:rosters) }
  it { should have_many(:enrollments) }
  it { should have_many(:tournaments).through(:enrollments) }
  it { should have_many(:registrations) }
  it { should have_many(:home_matches).class_name("Match").with_foreign_key("team_one_id") }
  it { should have_many(:away_matches).class_name("Match").with_foreign_key("team_two_id") }
  it { should validate_presence_of(:name) }

  describe "#matches" do
    let(:team) { create(:team) }
    let(:m) { create(:match, team_one: team) }

    it "returns a collection of the two teams playing in the match" do
      expect(team.matches).to match_array([m])
    end
  end

  describe ".add_filler_team" do
    let(:tournament) { create(:create_tournament_with_teams, team_count: 3) }

    it "adds an additional team to even out the team count" do
      expect { tournament.teams.add_filler_team }
        .to change { tournament.teams.reload.size }.from(3).to(4)
    end
  end
end
