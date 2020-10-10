require 'rails_helper'

RSpec.describe "CircuitExerciseSessionDetails", type: :request do
  describe "GET /circuit_exercise_session_details" do
    it "works! (now write some real specs)" do
      get circuit_exercise_session_details_path
      expect(response).to have_http_status(200)
    end
  end
end
