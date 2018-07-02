# frozen_string_literal: true

require "rails_helper"

describe "Charges", type: :request do
  describe "POST /charges" do
    let(:stripe_helper) { StripeMock.create_test_helper }
    before { StripeMock.start }
    after { StripeMock.stop }

    let(:user) { create(:user) }
    let(:tournament) { build_stubbed(:tournament) }
    let(:card) { { number: "4242424242424242", exp_month: 6, exp_year: 2019, cvc: "314" } }
    let(:successful_params) { { tournament_id: tournament.id, card: card } }

    before do
      allow(Tournament).to receive(:find).and_return(tournament)
    end

    context "when the payment is processed sucessfully" do
      it "returns a successful 201 created response" do
        post charges_path(tournament),
          headers: authenticated_header(user),
          params: successful_params

        expect(response).to have_http_status(201)
      end

      it "successfully creates an enrollment with the params sent" do
        post charges_path(tournament),
          headers: authenticated_header,
          params: successful_params

        expect(json_response_struct.paid).to eq(true)
        expect(json_response_struct.customer).to eq("test_cus_3")
        expect(json_response_struct.amount).to eq(tournament.fee.cents)
        expect(json_response_struct.description).to eq("Registration fee for #{tournament.name}")
      end
    end

    context "when the payment is processed unsucessfully" do
      let(:card_errors) do
        %i[incorrect_number invalid_number invalid_expiry_month invalid_expiry_year
           invalid_cvc expired_card incorrect_cvc card_declined missing processing_error
           incorrect_zip]
      end

      it "returns a 402 payment required response" do
        card_errors.each do |error|
          StripeMock.prepare_card_error(error)

          post charges_path(tournament),
            headers: authenticated_header(user),
            params: successful_params

          expect(response).to have_http_status(402)
        end
      end
    end
  end
end
