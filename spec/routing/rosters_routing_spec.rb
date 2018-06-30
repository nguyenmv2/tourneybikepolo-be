# frozen_string_literal: true

require "rails_helper"

describe RostersController, type: :routing do
  describe "routing" do
    it "routes to #create" do
      expect(post: "/rosters").to route_to("rosters#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/rosters/1").to route_to("rosters#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/rosters/1").to route_to("rosters#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/rosters/1").to route_to("rosters#destroy", id: "1")
    end
  end
end
