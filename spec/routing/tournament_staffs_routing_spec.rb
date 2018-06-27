# frozen_string_literal: true

require "rails_helper"

RSpec.describe TournamentStaffsController, type: :routing do
  describe "routing" do
    it "routes to #show" do
      expect(get: "/tournament_staffs/1").to route_to("tournament_staffs#show", id: "1")
    end

    it "routes to #create" do
      expect(post: "/tournament_staffs").to route_to("tournament_staffs#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/tournament_staffs/1").to route_to("tournament_staffs#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/tournament_staffs/1").to route_to("tournament_staffs#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/tournament_staffs/1").to route_to("tournament_staffs#destroy", id: "1")
    end
  end
end
