require 'rails_helper'

RSpec.describe HeatmapGridGenerator do
  let(:points) do
    [
      OpenStruct.new(latitude: -23.5, longitude: -46.6),
      OpenStruct.new(latitude: -23.51, longitude: -46.61)
    ]
  end

  it "returns a grid of size NxN" do
    grid = described_class.new(points, grid_size: 5).generate

    expect(grid.size).to eq(5)
    expect(grid.first.size).to eq(5)
  end

  it "counts points inside the grid" do
    grid = described_class.new(points, grid_size: 2).generate
    total = grid.flatten.sum

    expect(total).to eq(2)
  end
end
