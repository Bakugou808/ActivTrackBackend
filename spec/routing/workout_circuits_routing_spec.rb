require "rails_helper"

RSpec.describe WorkoutCircuitsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/workout_circuits").to route_to("workout_circuits#index")
    end

    it "routes to #show" do
      expect(:get => "/workout_circuits/1").to route_to("workout_circuits#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/workout_circuits").to route_to("workout_circuits#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/workout_circuits/1").to route_to("workout_circuits#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/workout_circuits/1").to route_to("workout_circuits#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/workout_circuits/1").to route_to("workout_circuits#destroy", :id => "1")
    end
  end
end
