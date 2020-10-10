require "rails_helper"

RSpec.describe CircuitExercisesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/circuit_exercises").to route_to("circuit_exercises#index")
    end

    it "routes to #show" do
      expect(:get => "/circuit_exercises/1").to route_to("circuit_exercises#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/circuit_exercises").to route_to("circuit_exercises#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/circuit_exercises/1").to route_to("circuit_exercises#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/circuit_exercises/1").to route_to("circuit_exercises#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/circuit_exercises/1").to route_to("circuit_exercises#destroy", :id => "1")
    end
  end
end
