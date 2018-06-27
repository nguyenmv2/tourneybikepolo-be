# frozen_string_literal: true

require "rails_helper"

RSpec.describe "TournamentStaffs", type: :request do
  describe "GET /tournament_staffs/:id" do
    it "returns a successful 200 response" do
      staff = build_stubbed :tournament_staff
      allow(TournamentStaff).to receive(:find).and_return(staff)

      get tournament_staff_path(staff)

      expect(response).to have_http_status(200)
    end

    it "returns a 404 response" do
      staff = build_stubbed :tournament_staff

      get tournament_staff_path(staff)

      expect(response).to have_http_status(404)
    end

    it "returns the user" do
      staff = build_stubbed :tournament_staff
      allow(TournamentStaff).to receive(:find).and_return(staff)

      get tournament_staff_path(staff)

      expect(json_response_struct.id).to eq(staff.id)
    end
  end

  describe "POST /tournament_staffs" do
    it "returns a successful 201 created response" do
      user = create(:user)
      tournament = create(:tournament)
      successful_params =
        { user_id: user.id, tournament_id: tournament.id, role: 1 }

      post tournament_staffs_path,
        headers: authenticated_header,
        params: { tournament_staff: successful_params }

      expect(response).to have_http_status(201)
    end

    it "successfully creates a tournament_staff with the params sent" do
      user = create(:user)
      tournament = create(:tournament)
      successful_params =
        { user_id: user.id, tournament_id: tournament.id, role: 1 }

      post tournament_staffs_path,
        headers: authenticated_header,
        params: { tournament_staff: successful_params }

      expect(json_response_struct.user_id).to eq(user.id)
      expect(json_response_struct.tournament_id).to eq(tournament.id)
      expect(json_response_struct.role).to eq(1)
    end
  end

  describe "PATCH /tournament_staffs/:id" do
    it "returns a successful 200 response" do
      staff = create :tournament_staff, role: 1
      successful_params = { role: 2 }

      patch tournament_staff_path(staff),
        headers: authenticated_header,
        params: { tournament_staff: successful_params }

      expect(response).to have_http_status(200)
    end

    it "successfully updates the tournament_staff with the params sent" do
      staff = create :tournament_staff, role: 1
      successful_params = { role: 2 }

      expect {
        patch tournament_staff_path(staff), headers: authenticated_header, params: { tournament_staff: successful_params }
      }.to change { staff.reload.role }.from(1).to(2)
    end

    it "returns a not found 404 response" do
      get tournament_staff_path(id: 1)

      expect(response).to have_http_status(404)
    end

    it "returns an unauthorized 401 response" do
      patch tournament_staff_path(id: 1)

      expect(response).to have_http_status(401)
    end
  end

  describe "DELETE /tournament_staff/:id" do
    it "returns a successful 204 response" do
      staff = create(:tournament_staff)
      delete tournament_staff_path(staff), headers: authenticated_header

      expect(response).to have_http_status(204)
    end

    it "successfully creates a tournament_staff with the params sent" do
      staff = create(:tournament_staff)

      expect {
        delete tournament_staff_path(staff), headers: authenticated_header
      }.to change { TournamentStaff.count }.from(1).to(0)
    end

    it "returns a 404 response" do
      staff = build_stubbed :tournament_staff

      patch tournament_staff_path(staff), headers: authenticated_header

      expect(response).to have_http_status(404)
    end
  end
end
