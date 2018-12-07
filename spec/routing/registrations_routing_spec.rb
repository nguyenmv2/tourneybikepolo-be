# frozen_string_literal: true

require "rails_helper"

describe RegistrationsController, type: :routing do
  describe "routing" do
    it "routes to #show" do
      expect(get: "/registrations/1").to route_to("registrations#show", id: "1")
    end

    it "routes to #create" do
      expect(post: "/registrations").to route_to("registrations#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/registrations/1").to route_to("registrations#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/registrations/1").to route_to("registrations#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/registrations/1").to route_to("registrations#destroy", id: "1")
    end
  end
end
