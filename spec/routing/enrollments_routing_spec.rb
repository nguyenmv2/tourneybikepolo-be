# frozen_string_literal: true

require "rails_helper"

describe EnrollmentsController, type: :routing do
  describe "routing" do
    it "routes to #create" do
      expect(post: "/enrollments").to route_to("enrollments#create")
    end

    it "routes to #destroy" do
      expect(delete: "/enrollments/1").to route_to("enrollments#destroy", id: "1")
    end
  end
end
