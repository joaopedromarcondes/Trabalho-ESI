require 'rails_helper'

RSpec.describe HeatmapBenchmark, type: :service do
  describe ".run" do
    it "roda benchmark em modo grid" do
      result = HeatmapBenchmark.run("grid")
      expect(result[:time_ms]).to be_a(Float)
      expect(result[:output_size]).to be >= 0
    end
  end

  describe ".run_all" do
    it "executa os 3 benchmarks" do
      results = HeatmapBenchmark.run_all
      expect(results.keys).to include("grid", "cluster", "hybrid")
    end
  end
end
