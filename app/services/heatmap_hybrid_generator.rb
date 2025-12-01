class HeatmapHybridGenerator
  def initialize
    @grid = HeatmapGridGenerator.new
    @cluster = HeatmapClusterGenerator.new
  end

  def generate
    grid_data = @grid.generate
    cluster_data = @cluster.generate

    # Exemplo de combinação: média entre grid e cluster
    (grid_data + cluster_data).group_by { |p| [p[:latitude], p[:longitude]] }.map do |_, vals|
      {
        latitude: vals.first[:latitude],
        longitude: vals.first[:longitude],
        level: vals.map { |v| v[:level] }.sum / vals.size
      }
    end
  end
end
