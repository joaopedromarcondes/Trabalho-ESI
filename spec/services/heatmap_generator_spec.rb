require 'rails_helper'
# Checa se o serviço de geração de heatmap funciona corretamente
RSpec.describe HeatmapGenerator, type: :service do  
  describe "#generate" do
    it "retorna dados das medições em formato adequado" do
      NoiseMeasurement.create!(latitude: -23.561, longitude: -46.656, level: 75)
      NoiseMeasurement.create!(latitude: -23.562, longitude: -46.657, level: 60)
      data = HeatmapGenerator.new.generate
      expect(data).to be_a(Array)
      expect(data.size).to eq(2)
      first = data.first
      expect(first).to include(:latitude, :longitude, :level)
    end
  end
end
