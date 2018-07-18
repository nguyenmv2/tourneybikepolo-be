# frozen_string_literal: true

require "rails_helper"

describe Match, type: :model do
  it { should belong_to(:tournament) }
  it { should belong_to(:team_one).class_name("Team").with_foreign_key("team_one_id") }
  it { should belong_to(:team_two).class_name("Team").with_foreign_key("team_two_id") }


  describe "#teams" do
    let(:team_one) { create(:team) }
    let(:team_two) { create(:team) }
    let(:m) { create(:match, team_one: team_one, team_two: team_two) }

    it "returns a collection of the two teams playing in the match" do
      expect(m.teams).to match_array([team_one, team_two])
    end
  end
end
