# frozen_string_literal: true

require "rails_helper"

describe User, type: :model do
  it { should have_many(:tournaments) }
  it { should have_many(:tournaments).through(:tournament_staffs) }
  it { should have_many(:rosters) }
  it { should have_many(:teams).through(:rosters) }
  it { should have_many(:registrations) }

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }

  describe "#payment_metadata" do
    it "returns a hash of user attributes" do
      u = build_stubbed(:user)

      expect(u.payment_metadata).to eq(user_id: u.id, first: u.first, last: u.last, phone: u.phone)
    end
  end
end
