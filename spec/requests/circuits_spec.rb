require 'rails_helper'

RSpec.describe "Circuits", type: :request do
  describe "GET /circuits" do
    it "works! (now write some real specs)" do
      get circuits_path
      expect(response).to have_http_status(200)
    end
  end
end
