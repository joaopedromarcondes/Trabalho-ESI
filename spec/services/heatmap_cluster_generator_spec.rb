require 'rails_helper'

RSpec.describe HeatmapClusterGenerator do
  before do
    NoiseMeasurement.delete_all
    200.times do
      NoiseMeasurement.create!(
        latitude: -23.55 + rand * 0.1,
        longitude: -46.63 + rand * 0.1,
        level: rand(40..100)
      )
    end
  end

  it "gera um array genérico" do
    result = described_class.new.generate
    expect(result).to be_an(Array)
  end

  it "não gera array vazio" do
    result = described_class.new.generate
    expect(result).not_to be_empty
  end

  it "cada cluster contém latitude, longitude e level" do
    point = described_class.new.generate.first
    expect(point).to include(:latitude, :longitude, :level)
  end
end
