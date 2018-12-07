# frozen_string_literal: true

require "rails_helper"

describe "Users", type: :request do
  describe "GET /users" do
    before do
      create_list(:user, 5)
      get users_path
    end

    it "returns a successful 200 response" do
      expect(response).to have_http_status(200)
    end

    it "returns all the users" do
      expect(json_response_struct.length).to eq(5)
    end
  end

  describe "GET /users/:id" do
    context "when user is found" do
      let(:user) { build_stubbed(:user) }

      before do
        allow(User).to receive(:find).and_return(user)
        get user_path(user)
      end

      it "returns a successful 200 response" do
        expect(response).to have_http_status(200)
      end

      it "returns the user" do
        expect(json_response_struct.id).to eq(user.id)
      end
    end

    context "when user is not found" do
      it "returns a 404 response" do
        get user_path(id: 1)

        expect(response).to have_http_status(404)
      end
    end
  end

  describe "POST /users" do
    context "when correct params are sent" do
      let(:successful_params) { { first: "Testy", last: "McTestsAlot", email: "testy@test.com", password: "taco123" } }

      before do
        post users_path, params: { user: successful_params }
      end

      it "returns a successful 201 created response" do
        expect(response).to have_http_status(201)
      end

      it "successfully creates a user with the params sent" do
        expect(json_response_struct.first).to eq("Testy")
        expect(json_response_struct.last).to eq("McTestsAlot")
        expect(json_response_struct.email).to eq("testy@test.com")
      end
    end

    context "when wrong params are sent" do
      it "returns a unsuccessful 422 response" do
        unsuccessful_params = { first: "Testy", last: "McTestsAlot", password: "taco123" }
        post users_path, params: { user: unsuccessful_params }

        expect(response).to have_http_status(422)
        expect(json_response_struct.email).to eq(["can't be blank"])
      end
    end
  end

  describe "PATCH /user/:id" do
    context "when params are valid" do
      let(:user) { create(:user, email: "old_email@test.com") }
      let(:successful_params) { { email: "new_email@test.com" } }

      it "returns a successful 200 response" do
        patch user_path(user),
          headers: authenticated_header(user),
          params: { user: successful_params }

        expect(response).to have_http_status(200)
      end

      it "successfully updates the user with the params sent" do
        expect do
          patch user_path(user), headers: authenticated_header(user), params: { user: successful_params }
        end.to change { user.reload.email }.from("old_email@test.com").to("new_email@test.com")
      end
    end

    context "when params are not valid" do
      it "returns a successful 422 response" do
        user = create :user
        create :user, email: "old_email@test.com"

        unsuccessful_params = { email: "old_email@test.com" }
        patch user_path(user), headers: authenticated_header(user), params: { user: unsuccessful_params }

        expect(response).to have_http_status(422)
        expect(json_response_struct.email).to eq(["has already been taken"])
      end

      it "returns a not found 404 response" do
        get user_path(id: 1)

        expect(response).to have_http_status(404)
      end

      it "returns an unauthorized 401 response" do
        patch user_path(id: 1)

        expect(response).to have_http_status(401)
      end
    end
  end

  describe "DELETE /user/:id" do
    context "when params are valid" do
      it "returns a successful 204 response" do
        user = create(:user)
        delete user_path(user),
          headers: authenticated_header(user)

        expect(response).to have_http_status(204)
      end

      it "successfully creates a user with the params sent" do
        user = create(:user)

        expect do
          delete user_path(user), headers: authenticated_header(user)
        end.to change { User.count }.from(1).to(0)
      end
    end

    context "when params are not valid" do
      it "returns a successful 422 response" do
        user = create :user
        create :user, email: "old_email@test.com"

        unsuccessful_params = { email: "old_email@test.com" }
        patch user_path(user),
          headers: authenticated_header(user),
          params: { user: unsuccessful_params }

        expect(response).to have_http_status(422)
        expect(json_response_struct.email).to eq(["has already been taken"])
      end

      it "returns a 401 response" do
        user = build_stubbed :user

        patch user_path(user), headers: authenticated_header(user)

        expect(response).to have_http_status(401)
      end
    end
  end
end
