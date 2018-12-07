# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Tournaments", type: :request do
  describe "GET /tournaments" do
    before do
      create_list(:tournament, 5)
      get tournaments_path
    end

    it "returns a successful 200 response" do
      expect(response).to have_http_status(200)
    end

    it "returns all the tournaments" do
      expect(json_response_struct.length).to eq(5)
    end
  end

  describe "GET /tournaments/:id" do
    context "when tournament is found" do
      let(:tournament) { build_stubbed(:tournament) }

      before do
        allow(Tournament).to receive(:find).and_return(tournament)
        get tournament_path(tournament)
      end

      it "returns a successful 200 response" do
        expect(response).to have_http_status(200)
      end

      it "returns the tournament" do
        expect(json_response_struct.id).to eq(tournament.id)
      end
    end

    context "when tournament is not found" do
      it "returns a 404 response" do
        get tournament_path(id: 1)

        expect(response).to have_http_status(404)
      end
    end
  end

  describe "POST /tournaments" do
    context "when correct params are sent" do
      let(:successful_params) do
        { name: "New Tourney", start_date: 15.days.from_now, end_date: 16.days.from_now,
          registration_start_date: 2.days.from_now, registration_end_date: 5.days.from_now,
          description: "New Description", team_cap: 20 }
      end

      before do
        post tournaments_path, headers: authenticated_header, params: { tournament: successful_params }
      end

      it "returns a successful 201 created response" do
        expect(response).to have_http_status(201)
      end

      it "successfully creates a tournament with the params sent" do
        expect(json_response_struct.name).to eq("New Tourney")
        # expect(json_response_struct.start_date).to eq(15.days.from_now)
        # expect(json_response_struct.end_date).to eq(16.days.from_now.to_s)
        # expect(json_response_struct.registration_start_date).to eq(2.days.from_now.to_s)
        # expect(json_response_struct.registration_end_date).to eq(5.days.from_now.to_s)
        expect(json_response_struct.description).to eq("New Description")
        expect(json_response_struct.team_cap).to eq(20)
      end
    end
  end

  describe "PATCH /tournament/:id" do
    context "when params are valid" do
      let(:tournament) { create(:tournament, name: "Team 1") }
      let(:successful_params) { { name: "Team 2" } }

      it "returns a successful 200 response" do
        patch tournament_path(tournament),
          headers: authenticated_header,
          params: { tournament: successful_params }

        expect(response).to have_http_status(200)
      end

      it "successfully updates the tournament with the params sent" do
        expect do
          patch tournament_path(tournament), headers: authenticated_header, params: { tournament: successful_params }
        end.to change { tournament.reload.name }.from("Team 1").to("Team 2")
      end
    end

    context "when params are not valid" do
      it "returns a not found 404 response" do
        get tournament_path(id: 1)

        expect(response).to have_http_status(404)
      end

      it "returns an unauthorized 401 response" do
        patch tournament_path(id: 1)

        expect(response).to have_http_status(401)
      end
    end
  end

  describe "DELETE /tournament/:id" do
    context "when params are valid" do
      it "returns a successful 204 response" do
        tournament = create(:tournament)
        delete tournament_path(tournament),
          headers: authenticated_header

        expect(response).to have_http_status(204)
      end

      it "successfully creates a tournament with the params sent" do
        tournament = create(:tournament)

        expect do
          delete tournament_path(tournament), headers: authenticated_header
        end.to change { Tournament.count }.from(1).to(0)
      end
    end

    context "when params are not valid" do
      it "returns a 404 response" do
        patch tournament_path(id: 1), headers: authenticated_header

        expect(response).to have_http_status(404)
      end
    end
  end
end
