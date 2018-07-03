# frozen_string_literal: true

require "rails_helper"

describe Token do
  let(:stripe_helper) { StripeMock.create_test_helper }
  let(:card) do
    { number: "4242424242424242", exp_month: 6, exp_year: 2019, cvc: "314" }
  end

  before { StripeMock.start }
  after { StripeMock.stop }

  describe "#create" do
    it "charges the user the registration fee for the tournament" do
      service = Token.create(card)

      card.each_key do |key|
        expect(service.card.send(key)).to eq(card[key])
      end
    end
  end
end
