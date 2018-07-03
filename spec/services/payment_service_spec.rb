# frozen_string_literal: true

require "rails_helper"

describe PaymentService do
  let(:stripe_helper) { StripeMock.create_test_helper }
  before { StripeMock.start }
  after { StripeMock.stop }

  describe "#charge" do
    let(:registration) { create(:registration) }
    let(:enrollment) { build_stubbed(:enrollment) }
    let(:objects) do
      { user: create(:user),
        team: build_stubbed(:team),
        tournament: build_stubbed(:tournament) }
    end
    let(:card) { { number: "4242424242424242", exp_month: 6, exp_year: 2019, cvc: "314" } }

    before do
      enrollments = objects[:tournament].enrollments # empty collection
      allow(objects[:tournament]).to receive(:enrollments).and_return(enrollments)
      allow(enrollments).to receive(:find_by).and_return(enrollment)
      allow(Registration).to receive(:find_by).and_return(registration)
    end

    it "charges the user the registration fee for the tournament" do
      service = PaymentService.new(card, objects).charge

      expect(service.paid).to eq(true)
      expect(service.customer).to eq(objects[:user].stripe_customer_id)
      expect(service.amount).to eq(objects[:tournament].fee.cents)
      expect(service.description).to eq("Registration fee for #{objects[:tournament].name}")
    end
  end
end
