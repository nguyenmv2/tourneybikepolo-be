# frozen_string_literal: true

require "rails_helper"

describe Customer do
  let(:stripe_helper) { StripeMock.create_test_helper }
  let(:card) do
    { number: "4242424242424242", exp_month: 6, exp_year: 2019, cvc: "314" }
  end

  before { StripeMock.start }
  after { StripeMock.stop }

  describe "#create" do
    context "when user already has a customer_id" do
      it "charges the user the registration fee for the tournament" do
        user = create(:user, stripe_customer_id: "cus_ANzvvR0Ktmgbr1")
        service = Customer.create(card, user)

        expect(service).to eq(user.stripe_customer_id)
      end
    end

    context "when user does not have a customer_id" do
      it "charges the user the registration fee for the tournament" do
        user = create(:user)
        service = Customer.create(card, user)

        expect(service).to eq("test_cus_3")
      end
    end
  end

  describe "customer" do
    it "creates a stripe customer" do
      user = build_stubbed(:user)
      service = Customer.new(card, user).send(:customer)

      expect(service.email).to eq(user.email)
      expect(service.metadata.user_id).to eq(user.id)
      expect(service.metadata.first).to eq(user.first)
      expect(service.metadata.last).to eq(user.last)
      expect(service.metadata.phone).to eq(user.phone)
    end
  end
end
