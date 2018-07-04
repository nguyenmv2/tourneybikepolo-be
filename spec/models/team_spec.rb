# frozen_string_literal: true

require "rails_helper"

describe Team, type: :model do
  it { should have_many(:rosters) }
  it { should have_many(:players).through(:rosters) }
  it { should have_many(:enrollments) }
  it { should have_many(:tournaments).through(:enrollments) }
  it { should have_many(:registrations) }
  it { should validate_presence_of(:name) }
end
