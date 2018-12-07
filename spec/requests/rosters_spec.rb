# frozen_string_literal: true

require "rails_helper"

describe "Rosters", type: :request do
  describe "POST /rosters" do
    let(:team) { create(:team) }
    let(:user) { create(:user) }
    let(:team) { create(:team) }
    let(:successful_params) { { team_id: team.id, player_id: user.id, role: 1 } }

    context "when roster is created" do
      before do
        post rosters_path(team, user),
          headers: authenticated_header,
          params: { roster: successful_params }
      end

      it "returns a successful 201 created response" do
        expect(response).to have_http_status(201)
      end

      it "successfully creates an enrollment with the params sent" do
        expect(json_response_struct.team_id).to eq(team.id)
        expect(json_response_struct.player_id).to eq(user.id)
        expect(json_response_struct.role).to eq(1)
      end
    end

    context "when roster fails to create" do
      let(:unsuccessful_params) { { role: 1 } }

      before do
        post rosters_path(team, user),
          headers: authenticated_header,
          params: { roster: unsuccessful_params }
      end

      it "returns an unprocessable entity 422" do
        expect(response).to have_http_status(422)
      end

      it "renders an error response" do
        expect(json_response_struct.player).to eq(["must exist"])
        expect(json_response_struct.team).to eq(["must exist"])
      end
    end
  end

  describe "PATCH /rosters/:id" do
    context "when correct params are sent" do
      let(:roster) { create(:roster, role: 1) }
      let(:successful_params) { { role: 2 } }

      it "returns a successful 200 response" do
        patch roster_path(roster),
          headers: authenticated_header,
          params: { roster: successful_params }

        expect(response).to have_http_status(200)
      end

      it "successfully updates the roster with the params sent" do
        expect do
          patch roster_path(roster), headers: authenticated_header, params: { roster: successful_params }
        end.to change { roster.reload.role }.from(1).to(2)
      end
    end

    context "when there are errors" do
      it "returns a not found 404 response" do
        patch roster_path(id: 1), headers: authenticated_header

        expect(response).to have_http_status(404)
      end

      it "renders an error response" do
        unsuccessful_params = { team_id: 0 }
        roster = create(:roster)

        patch roster_path(id: roster.id),
          headers: authenticated_header,
          params: { roster: unsuccessful_params }

        expect(json_response_struct.team).to eq(["must exist"])
      end

      it "returns an unauthorized 401 response" do
        patch roster_path(id: 1)

        expect(response).to have_http_status(401)
      end
    end
  end

  describe "DELETE /rosters/:id" do
    it "returns a successful 204 response" do
      roster = create(:roster)

      delete roster_path(roster), headers: authenticated_header

      expect(response).to have_http_status(204)
    end

    it "successfully deletes the enrollment with the params sent" do
      roster = create(:roster)
      expect { delete roster_path(roster), headers: authenticated_header }
        .to change { Roster.count }
        .from(1)
        .to(0)
    end
  end
end
