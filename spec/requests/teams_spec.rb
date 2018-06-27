# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Teams", type: :request do
  describe "GET /teams/:id" do
    it "returns a successful 200 response" do
      team = build_stubbed :team
      allow(Team).to receive(:find).and_return(team)

      get team_path(team)

      expect(response).to have_http_status(200)
    end

    it "returns a 404 response" do
      team = build_stubbed :team

      get team_path(team)

      expect(response).to have_http_status(404)
    end

    it "returns the user" do
      team = build_stubbed :team
      allow(Team).to receive(:find).and_return(team)

      get team_path(team)

      expect(json_response_struct.id).to eq(team.id)
    end
  end

  describe "POST /teams" do
    let(:logo) { Faker::Avatar.image }

    it "returns a successful 201 created response" do
      successful_params =
        { name: "New Team", desription: "New Description", logo: logo, player_count: 5 }

      post teams_path,
        headers: authenticated_header,
        params: { team: successful_params }

      expect(response).to have_http_status(201)
    end

    it "successfully creates a user with the params sent" do
      successful_params =
        { name: "New Team", description: "New Description", logo: logo, player_count: 5 }

      post teams_path,
        headers: authenticated_header,
        params: { team: successful_params }

      expect(json_response_struct.name).to eq("New Team")
      expect(json_response_struct.description).to eq("New Description")
      expect(json_response_struct.logo).to eq(logo)
      expect(json_response_struct.player_count).to eq(5)
    end
  end

  describe "PATCH /teams/:id" do
    it "returns a successful 200 response" do
      team = create :team, name: "Team 1"
      successful_params = { name: "Team 2" }

      patch team_path(team),
        headers: authenticated_header,
        params: { team: successful_params }

      expect(response).to have_http_status(200)
    end

    it "successfully updates the user with the params sent" do
      team = create :team, name: "Team 1"
      successful_params = { name: "Team 2" }

      expect {
        patch team_path(team), headers: authenticated_header, params: { team: successful_params }
      }.to change { team.reload.name }.from("Team 1").to("Team 2")
    end

    it "returns a not found 404 response" do
      get team_path(id: 1)

      expect(response).to have_http_status(404)
    end

    it "returns an unauthorized 401 response" do
      patch team_path(id: 1)

      expect(response).to have_http_status(401)
    end
  end

  describe "DELETE /teams/:id" do
    it "returns a successful 204 response" do
      team = create(:team)
      delete team_path(team), headers: authenticated_header

      expect(response).to have_http_status(204)
    end

    it "successfully creates a user with the params sent" do
      team = create(:team)

      expect {
        delete team_path(team), headers: authenticated_header
      }.to change { Team.count }.from(1).to(0)
    end

    it "returns a 404 response" do
      team = build_stubbed :team

      patch team_path(team), headers: authenticated_header

      expect(response).to have_http_status(404)
    end
  end
end
