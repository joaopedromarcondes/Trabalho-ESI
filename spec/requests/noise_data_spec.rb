require 'rails_helper'

RSpec.describe "NoiseData", type: :request do
  it "retorna dados de ruído em JSON" do
    NoiseMeasurement.create!(latitude: -23.561, longitude: -46.656, level: 75)
    get '/noise_data'
    expect(response).to have_http_status(:success)
    json = JSON.parse(response.body)
    expect(json.first).to include("latitude", "longitude", "level")
  end
end
