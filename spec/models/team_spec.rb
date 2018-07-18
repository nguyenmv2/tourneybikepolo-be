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
end
