# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Registrations", type: :request do
  describe "GET /registrations/:id" do
    context "when registration is found" do
      let(:registration) { build_stubbed(:registration) }

      before do
        allow(Registration).to receive(:find).and_return(registration)
      end

      it "returns a successful 200 response" do
        get registration_path(registration), headers: authenticated_header

        expect(response).to have_http_status(200)
      end

      it "returns the registration" do
        get registration_path(registration), headers: authenticated_header

        expect(json_response_struct.id).to eq(registration.id)
      end
    end

    context "when registration is not found" do
      it "returns a 404 response" do
        get registration_path(id: 1), headers: authenticated_header

        expect(response).to have_http_status(404)
      end
    end
  end

  describe "POST /registrations" do
    context "when correct params are sent" do
      let(:team) { create(:team) }
      let(:user) { create(:user) }
      let(:enrollment) { create(:enrollment) }
      let(:successful_params) { { team_id: team.id, user_id: user.id, enrollment_id: enrollment.id, status: 1 } }

      before do
        post registrations_path,
          headers: authenticated_header,
          params: { registration: successful_params }
      end

      it "returns a successful 201 created response" do
        expect(response).to have_http_status(201)
      end

      it "successfully creates a registration with the params sent" do
        expect(json_response_struct.team_id).to eq(team.id)
        expect(json_response_struct.user_id).to eq(user.id)
        expect(json_response_struct.enrollment_id).to eq(enrollment.id)
      end
    end

    context "when wrong params are sent" do
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
  end

  describe "PATCH /registration/:id" do
    let(:registration) { create(:registration, status: 2) }
    let(:successful_params) { { status: 1 } }

    it "returns a successful 200 response" do
      patch registration_path(registration),
        headers: authenticated_header,
        params: { registration: successful_params }

      expect(response).to have_http_status(200)
    end

    it "successfully updates the registration with the params sent" do
      expect {
        patch registration_path(registration), headers: authenticated_header, params: { registration: successful_params }
      }.to change { registration.reload.status }.from(2).to(1)
    end
  end

  describe "DELETE /registration/:id" do
    it "returns a successful 204 response" do
      registration = create(:registration)

      delete registration_path(registration),
        headers: authenticated_header

      expect(response).to have_http_status(204)
    end

    it "successfully deletes the registration" do
      registration = create(:registration)

      expect {
        delete registration_path(registration), headers: authenticated_header
      }.to change { Registration.count }.from(1).to(0)
    end
  end
end
