require "rails_helper"

RSpec.describe CircuitsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/circuits").to route_to("circuits#index")
    end

    it "routes to #show" do
      expect(:get => "/circuits/1").to route_to("circuits#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/circuits").to route_to("circuits#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/circuits/1").to route_to("circuits#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/circuits/1").to route_to("circuits#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/circuits/1").to route_to("circuits#destroy", :id => "1")
    end
  end
end
