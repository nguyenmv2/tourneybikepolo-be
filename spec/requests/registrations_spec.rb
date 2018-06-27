# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Registrations", type: :request do
  describe "GET /registrations/:id" do
    let(:registration) { build_stubbed(:registration) }

    it "returns a successful 200 response" do
      allow(Registration).to receive(:find).and_return(registration)

      get registration_path(registration), headers: authenticated_header

      expect(response).to have_http_status(200)
    end

    it "returns a 404 response" do
      get registration_path(registration), headers: authenticated_header

      expect(response).to have_http_status(404)
    end

    it "returns the user" do
      allow(Registration).to receive(:find).and_return(registration)

      get registration_path(registration), headers: authenticated_header

      expect(json_response_struct.id).to eq(registration.id)
    end
  end

  describe "POST /registrations" do
    it "returns a successful 201 created response" do
      team = create(:team)
      user = create(:user)
      enrollment = create(:enrollment)
      successful_params = { team_id: team.id, user_id: user.id, enrollment_id: enrollment.id, status: 1 }

      post registrations_path,
        headers: authenticated_header,
        params: { registration: successful_params }

      expect(response).to have_http_status(201)
    end

    it "successfully creates a registration with the params sent" do
      team = create(:team)
      user = create(:user)
      enrollment = create(:enrollment)
      successful_params = { team_id: team.id, user_id: user.id, enrollment_id: enrollment.id, status: 1 }

      post registrations_path,
        headers: authenticated_header,
        params: { registration: successful_params }

      expect(json_response_struct.team_id).to eq(team.id)
      expect(json_response_struct.user_id).to eq(user.id)
      expect(json_response_struct.enrollment_id).to eq(enrollment.id)
    end

    it "returns a successful 422 response" do
      unsuccessful_params = { team_id: 1, user_id: 1, enrollment_id: 1, status: 1 }
      post registrations_path,
        headers: authenticated_header,
        params: { registration: unsuccessful_params }

      expect(response).to have_http_status(422)
      expect(json_response_struct.team).to eq(["must exist"])
      expect(json_response_struct.user).to eq(["must exist"])
      expect(json_response_struct.enrollment).to eq(["must exist"])
    end
  end

  describe "PATCH /registration/:id" do
    it "returns a successful 200 response" do
      registration = create :registration, status: 2
      successful_params = { status: 1 }

      patch registration_path(registration),
        headers: authenticated_header,
        params: { registration: successful_params }

      expect(response).to have_http_status(200)
    end

    it "successfully creates a user with the params sent" do
      registration = create :registration, status: 2
      successful_params = { status: 1 }

      expect {
        patch registration_path(registration), headers: authenticated_header, params: { registration: successful_params }
      }.to change { registration.reload.status }.from(2).to(1)
    end
  end

  describe "DELETE /user/:id" do
    it "returns a successful 204 response" do
      user = create(:user)
      delete user_path(user),
        headers: authenticated_header(user)

      expect(response).to have_http_status(204)
    end

    it "successfully creates a user with the params sent" do
      user = create(:user)

      expect {
        delete user_path(user), headers: authenticated_header(user)
      }.to change { User.count }.from(1).to(0)
    end
  end
end
