require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:tournaments) }
  it { should have_many(:tournaments).through(:tournament_staffs) }
  it { should have_many(:rosters) }
  it { should have_many(:teams).through(:rosters) }
  it { should have_many(:registrations) }

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
end
