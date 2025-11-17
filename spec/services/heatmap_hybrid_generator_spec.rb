require 'rails_helper'

RSpec.describe HeatmapHybridGenerator do
  let(:points) do
    [
      OpenStruct.new(latitude: -10, longitude: -20),
      OpenStruct.new(latitude: -10, longitude: -20),
      OpenStruct.new(latitude: -10, longitude: -20),
      OpenStruct.new(latitude: -10, longitude: -20),
      OpenStruct.new(latitude: -11, longitude: -19)
    ]
  end

  it "returns grid, clusters and frequent points" do
    output = described_class.new(points).generate

    expect(output[:grid]).not_to be_nil
    expect(output[:clusters]).not_to be_nil
    expect(output[:frequent_points].length).to eq(1)
  end
end
