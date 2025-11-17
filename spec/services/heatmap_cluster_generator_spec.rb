require 'rails_helper'

RSpec.describe HeatmapClusterGenerator do
  let(:points) do
    [
      OpenStruct.new(latitude: 1.0, longitude: 1.0),
      OpenStruct.new(latitude: 1.0001, longitude: 1.0001)
    ]
  end

  it "groups points into clusters" do
    clusters = described_class.new(points, max_distance: 0.001).generate
    expect(clusters.length).to eq(1)
    expect(clusters.first[:points].length).to eq(2)
  end

  it "creates separate clusters when distance is large" do
    far = [
      OpenStruct.new(latitude: 1.0, longitude: 1.0),
      OpenStruct.new(latitude: 2.0, longitude: 2.0)
    ]

    clusters = described_class.new(far, max_distance: 0.01).generate
    expect(clusters.length).to eq(2)
  end
end
