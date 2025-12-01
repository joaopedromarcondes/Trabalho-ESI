class HeatmapBenchmark
  MODES = %w[grid cluster hybrid].freeze

  def self.run_all
    results = {}

    MODES.each do |mode|
      results[mode] = run(mode)
    end

    results
  end

  def self.run(mode)
    generator = case mode
                when "grid" then HeatmapGridGenerator.new
                when "cluster" then HeatmapClusterGenerator.new
                when "hybrid" then HeatmapHybridGenerator.new
                else raise ArgumentError, "Modo inválido: #{mode}"
                end

    # medir tempo
    t0 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    output = generator.generate
    t1 = Process.clock_gettime(Process::CLOCK_MONOTONIC)

    {
      mode: mode,
      time_ms: ((t1 - t0) * 1000).round(2),
      output_size: output.size,
      sample: output.first(3)
    }
  end
end
