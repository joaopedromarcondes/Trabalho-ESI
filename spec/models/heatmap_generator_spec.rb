require 'rails_helper'

RSpec.describe HeatmapGenerator, type: :service do
  describe "#generate" do
    it "retorna dados de ruído agrupados por região" do
      NoiseMeasurement.create!(latitude: -23.561, longitude: -46.656, level: 75)
      NoiseMeasurement.create!(latitude: -23.562, longitude: -46.657, level: 60)

      data = HeatmapGenerator.new.generate

      expect(data).to be_a(Array)
      expect(data.first).to include(:latitude, :longitude, :level)
    end
  end
end
