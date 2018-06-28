# frozen_string_literal: true

require "rails_helper"

RSpec.describe Tournament, type: :model do
  it { should have_many(:tournament_staffs) }
  it { should have_many(:users).through(:tournament_staffs) }
  it { should have_many(:enrollments) }
  it { should have_many(:teams).through(:enrollments) }
end
