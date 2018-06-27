# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Enrollments", type: :request do
  describe "POST /enrollements" do
    let(:team) { create(:team) }
    let(:tournament) { create(:tournament) }
    let(:successful_params) { { team_id: team.id, tournament_id: tournament.id } }

    it "returns a successful 201 created response" do
      post enrollments_path(team, tournament),
        headers: authenticated_header,
        params: { enrollment: successful_params }

      expect(response).to have_http_status(201)
    end

    it "successfully creates an enrollment with the params sent" do
      post enrollments_path(team, tournament),
        headers: authenticated_header,
        params: { enrollment: successful_params }

      expect(json_response_struct.team_id).to eq(team.id)
      expect(json_response_struct.tournament_id).to eq(tournament.id)
    end
  end

  describe "DELETE /enrollments/:id" do
    it "returns a successful 204 response" do
      enrollment = create(:enrollment)

      delete enrollment_path(enrollment), headers: authenticated_header

      expect(response).to have_http_status(204)
    end

    it "successfully deletes the enrollment with the params sent" do
      enrollment = create(:enrollment)
      expect { delete enrollment_path(enrollment), headers: authenticated_header }
        .to change { Enrollment.count }
        .from(1)
        .to(0)
    end
  end
end
