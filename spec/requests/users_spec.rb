# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Users", type: :request do
  describe "GET /users" do
    it "returns a successful 200 response" do
      get users_path

      expect(response).to have_http_status(200)
    end

    it "returns all the students" do
      create_list(:user, 5)
      get users_path

      expect(json_response_struct.length).to eq(5)
    end
  end

  describe "GET /users/:id" do
    it "returns a successful 200 response" do
      user = build_stubbed :user
      allow(User).to receive(:find).and_return(user)

      get user_path(user)

      expect(response).to have_http_status(200)
    end

    it "returns a 404 response" do
      user = build_stubbed :user

      get user_path(user)

      expect(response).to have_http_status(404)
    end

    it "returns the user" do
      user = build_stubbed :user
      allow(User).to receive(:find).and_return(user)

      get user_path(user)

      expect(json_response_struct.id).to eq(user.id)
    end
  end

  describe "POST /users" do
    it "returns a successful 201 created response" do
      successful_params = { first: "Testy", last: "McTestsAlot", email: "test@test.com", password: "taco123"}

      post users_path, params: { user: successful_params }

      expect(response).to have_http_status(201)
    end

    it "successfully creates a user with the params sent" do
      successful_params = { first: "Testy", last: "McTestsAlot", email: "testy@test.com", password: "taco123"}

      post users_path, params: { user: successful_params }

      expect(json_response_struct.first).to eq("Testy")
      expect(json_response_struct.last).to eq("McTestsAlot")
      expect(json_response_struct.email).to eq("testy@test.com")
    end

    it "returns a successful 422 response" do
      unsuccessful_params = { first: "Testy", last: "McTestsAlot", password: "taco123"}
      post users_path, params: { user: unsuccessful_params }

      expect(response).to have_http_status(422)
      expect(json_response_struct.email).to eq(["can't be blank"])
    end
  end

  describe "PATCH /user/:id" do
    context "when params are valid" do
      it "returns a successful 200 response" do
        user = create :user, email: "old_email@test.com"
        successful_params = { email: "new_email@test.com" }

        patch user_path(user), params: { user: successful_params }

        expect(response).to have_http_status(200)
      end

      it "successfully updates the user with the params sent" do
        user = create :user, email: "old_email@test.com"
        successful_params = { email: "new_email@test.com" }

        expect { patch user_path(user), params: { user: successful_params } }
          .to change { user.reload.email }
          .from("old_email@test.com")
          .to("new_email@test.com")
      end
    end

    context "when params are not valid" do
      it "returns a successful 422 response" do

        user = create :user
        create :user, email: "old_email@test.com"

        unsuccessful_params = { email: "old_email@test.com" }
        patch user_path(user), params: { user: unsuccessful_params }

        expect(response).to have_http_status(422)
        expect(json_response_struct.email).to eq(["has already been taken"])
      end

      it "returns a 404 response" do
        user = build_stubbed :user

        patch user_path(user)

        expect(response).to have_http_status(404)
      end
    end
  end

  describe "DELETE /user/:id" do
    context "when params are valid" do
      it "returns a successful 204 response" do
        user = create(:user)
        delete user_path(user)

        expect(response).to have_http_status(204)
      end

      it "successfully creates a user with the params sent" do
        user = create(:user)
        expect { delete user_path(user) }.to change { User.count }.from(1).to(0)
      end
    end

    context "when params are not valid" do
      it "returns a successful 422 response" do

        user = create :user
        create :user, email: "old_email@test.com"

        unsuccessful_params = { email: "old_email@test.com" }
        patch user_path(user), params: { user: unsuccessful_params }

        expect(response).to have_http_status(422)
        expect(json_response_struct.email).to eq(["has already been taken"])
      end

      it "returns a 404 response" do
        user = build_stubbed :user

        patch user_path(user)

        expect(response).to have_http_status(404)
      end
    end
  end
end
