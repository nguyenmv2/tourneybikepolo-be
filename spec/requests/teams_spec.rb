# frozen_string_literal: true

require "rails_helper"

describe "Teams", type: :request do
  describe "GET /teams/:id" do
    context "when team is found" do
      let(:team) { build_stubbed(:team) }

      before do
        allow(Team).to receive(:find).and_return(team)
      end

      it "returns a successful 200 response" do
        get team_path(team)

        expect(response).to have_http_status(200)
      end

      it "returns the team" do
        get team_path(team)

        expect(json_response_struct.id).to eq(team.id)
      end
    end

    context "when team is not found" do
      it "returns a 404 response" do
        get team_path(id: 1)

        expect(response).to have_http_status(404)
      end
    end
  end

  describe "POST /teams" do
    let(:logo) { Faker::Avatar.image }
    let(:successful_params) { { name: "New Team", description: "New Description", logo: logo, player_count: 5 } }

    before do
      post teams_path,
        headers: authenticated_header,
        params: { team: successful_params }
    end

    it "returns a successful 201 created response" do
      expect(response).to have_http_status(201)
    end

    it "successfully creates a team with the params sent" do
      expect(json_response_struct.name).to eq("New Team")
      expect(json_response_struct.description).to eq("New Description")
      expect(json_response_struct.logo).to eq(logo)
      expect(json_response_struct.player_count).to eq(5)
    end
  end

  describe "PATCH /teams/:id" do
    context "when correct params are sent" do
      let(:team) { create :team, name: "Team 1" }
      let(:successful_params) { { name: "Team 2" } }

      it "returns a successful 200 response" do
        patch team_path(team),
          headers: authenticated_header,
          params: { team: successful_params }

        expect(response).to have_http_status(200)
      end

      it "successfully updates the team with the params sent" do
        expect {
          patch team_path(team), headers: authenticated_header, params: { team: successful_params }
        }.to change { team.reload.name }.from("Team 1").to("Team 2")
      end
    end

    context "when wrong params are sent" do
      it "returns a not found 404 response" do
        get team_path(id: 1)

        expect(response).to have_http_status(404)
      end

      it "returns an unauthorized 401 response" do
        patch team_path(id: 1)

        expect(response).to have_http_status(401)
      end
    end
  end

  describe "DELETE /teams/:id" do
    context "when team is found" do
      it "returns a successful 204 response" do
        team = create(:team)
        delete team_path(team), headers: authenticated_header

        expect(response).to have_http_status(204)
      end

      it "successfully deletes a team with the params sent" do
        team = create(:team)
        expect {
          delete team_path(team), headers: authenticated_header
        }.to change { Team.count }.from(1).to(0)
      end
    end

    context "when team is not found" do
      it "returns a 404 response" do
        patch team_path(id: 1), headers: authenticated_header

        expect(response).to have_http_status(404)
      end
    end
  end
end
