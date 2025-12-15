require 'rails_helper'
# checa se os dados de ruído são retornados corretamente pela API
RSpec.describe "NoiseData", type: :request do
  it "retorna dados de ruído em JSON" do
    user = User.create!(
      email: "noise@test.com",
      password: "password123",
      name: "Noise User",
      confirmed_at: Time.current
    )
    NoiseMeasurement.create!(
      user: user,
      latitude: -23.561,
      longitude: -46.656,
      level: 75
    )
    get '/noise_data'
    expect(response).to have_http_status(:success)
    json = JSON.parse(response.body)
    expect(json.first).to include("latitude", "longitude", "level")
  end
end
