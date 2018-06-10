require "rails_helper"

RSpec.describe TournamentStaffsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/tournament_staffs").to route_to("tournament_staffs#index")
    end

    it "routes to #new" do
      expect(:get => "/tournament_staffs/new").to route_to("tournament_staffs#new")
    end

    it "routes to #show" do
      expect(:get => "/tournament_staffs/1").to route_to("tournament_staffs#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/tournament_staffs/1/edit").to route_to("tournament_staffs#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/tournament_staffs").to route_to("tournament_staffs#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/tournament_staffs/1").to route_to("tournament_staffs#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/tournament_staffs/1").to route_to("tournament_staffs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/tournament_staffs/1").to route_to("tournament_staffs#destroy", :id => "1")
    end

  end
end
