# frozen_string_literal: true

require "rails_helper"

describe Match, type: :model do
  it { should belong_to(:tournament) }
  it { should belong_to(:team_one).class_name("Team").with_foreign_key("team_one_id") }
  it { should belong_to(:team_two).class_name("Team").with_foreign_key("team_two_id") }
  it { should have_one(:timer).dependent(:destroy) }

  it_behaves_like "timeable"

  describe "#teams" do
    let(:team_one) { create(:team) }
    let(:team_two) { create(:team) }
    let(:m) { create(:match, team_one: team_one, team_two: team_two) }

    it "returns a collection of the two teams playing in the match" do
      expect(m.teams).to match_array([team_one, team_two])
    end
  end

  describe "#score" do
    let(:team_one) { build_stubbed(:team) }
    let(:team_two) { build_stubbed(:team) }
    let(:m) { build_stubbed(:match, team_one: team_one, team_two: team_two) }

    it "returns a hash with team ids for keys and for scores values" do
      allow(Team).to receive(:where).and_return([team_one, team_two])
      expected_result = { m.team_one.name => m.team_one_score,
                          m.team_two.name => m.team_two_score }
      expect(m.score).to eq(expected_result)
    end
  end

  describe "#increment_score" do
    let(:m) { create(:match, team_one_score: 0, team_two_score: 0) }

    context "when team_one scores" do
      it "increases their score by one" do
        expect { m.increment_score(m.team_one) }.to change { m.team_one_score }.from(0).to(1)
      end
    end

    context "when team_two scores" do
      it "increases their score by one" do
        expect { m.increment_score(m.team_two) }.to change { m.team_two_score }.from(0).to(1)
      end
    end
  end

  describe "#decrement_score" do
    let(:m) { create(:match, team_one_score: 1, team_two_score: 1) }

    context "when team_one has a point taken away" do
      it "decreases their score by one" do
        expect { m.decrement_score(m.team_one) }.to change { m.team_one_score }.from(1).to(0)
      end
    end

    context "when team_two has a point taken away" do
      it "decreases their score by one" do
        expect { m.decrement_score(m.team_two) }.to change { m.team_two_score }.from(1).to(0)
      end
    end
  end
end
