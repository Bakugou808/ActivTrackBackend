require 'rails_helper'

RSpec.describe "WorkoutCircuits", type: :request do
  describe "GET /workout_circuits" do
    it "works! (now write some real specs)" do
      get workout_circuits_path
      expect(response).to have_http_status(200)
    end
  end
end
