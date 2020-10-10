require "rails_helper"

RSpec.describe CircuitExerciseSessionDetailsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/circuit_exercise_session_details").to route_to("circuit_exercise_session_details#index")
    end

    it "routes to #show" do
      expect(:get => "/circuit_exercise_session_details/1").to route_to("circuit_exercise_session_details#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/circuit_exercise_session_details").to route_to("circuit_exercise_session_details#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/circuit_exercise_session_details/1").to route_to("circuit_exercise_session_details#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/circuit_exercise_session_details/1").to route_to("circuit_exercise_session_details#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/circuit_exercise_session_details/1").to route_to("circuit_exercise_session_details#destroy", :id => "1")
    end
  end
end
