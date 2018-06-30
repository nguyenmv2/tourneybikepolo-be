# frozen_string_literal: true

require "rails_helper"

describe PaymentService do
  let(:stripe_helper) { StripeMock.create_test_helper }
  before { StripeMock.start }
  after { StripeMock.stop }

  describe "#charge" do
    it "charges the user the registration fee for the tournament" do
      card = { number: "4242424242424242", exp_month: 6, exp_year: 2019, cvc: "314" }
      user = create(:user)
      tournament = build_stubbed(:tournament)
      service = PaymentService.new(card, user, tournament).charge

      expect(service.paid).to eq(true)
      expect(service.customer).to eq(user.stripe_customer_id)
      expect(service.amount).to eq(tournament.fee.cents)
      expect(service.description).to eq("Registration fee for #{tournament.name}")
    end
  end
end
