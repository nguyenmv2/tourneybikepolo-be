# frozen_string_literal: true

require "rails_helper"

describe Registration, type: :model do
  it { should belong_to(:team) }
  it { should belong_to(:user) }
  it { should belong_to(:enrollment) }
  it do
    should define_enum_for(:status)
      .with_values(failed: 0, succeeded: 1, pending: 2)
  end

  describe ".fetch" do
    let(:registration) { build_stubbed(:registration) }
    let(:enrollment) { build_stubbed(:enrollment) }
    let(:hsh) do
      { user: build_stubbed(:user),
        team: build_stubbed(:team),
        tournament: build_stubbed(:tournament) }
    end

    it "returns the associated registration record" do
      enrollments = hsh[:tournament].enrollments # empty collection

      allow(hsh[:tournament]).to receive(:enrollments).and_return(enrollments)
      allow(enrollments).to receive(:find_by).and_return(enrollment)
      allow(Registration).to receive(:find_by).and_return(registration)

      expect(Registration.fetch(**hsh)).to eq(registration)
    end
  end
end
