require 'rails_helper'

RSpec.describe "CircuitExercises", type: :request do
  describe "GET /circuit_exercises" do
    it "works! (now write some real specs)" do
      get circuit_exercises_path
      expect(response).to have_http_status(200)
    end
  end
end
