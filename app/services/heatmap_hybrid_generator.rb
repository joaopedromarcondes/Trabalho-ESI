class HeatmapHybridGenerator
  def initialize(locations)
    @locations = locations
  end

  def generate
    return [] if @locations.empty?

    frequent_points = @locations.group_by { |l| [l.latitude, l.longitude] }
                                .filter { |_p, list| list.size > 3 }
                                .map { |p, list| { point: p, count: list.size } }

    grid = HeatmapGridGenerator.new(@locations, grid_size: 8).generate
    clusters = HeatmapClusterGenerator.new(@locations, max_distance: 0.008).generate

    {
      frequent_points: frequent_points,
      grid: grid,
      clusters: clusters
    }
  end
end
