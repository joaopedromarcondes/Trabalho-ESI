class HeatmapGridGenerator
  DEFAULT_RESOLUTION = 0.01 # ~1 km dependendo da latitude

  def initialize(resolution: DEFAULT_RESOLUTION)
    @resolution = resolution
  end

  def generate
    NoiseMeasurement.all.map do |n|
      {
        latitude: (n.latitude / @resolution).round * @resolution,
        longitude: (n.longitude / @resolution).round * @resolution,
        level: n.level
      }
    end.group_by { |c| [c[:latitude], c[:longitude]] }
      .map do |(lat, lng), cells|
        {
          latitude: lat,
          longitude: lng,
          level: (cells.sum { |c| c[:level] } / cells.size.to_f).round
        }
      end
  end
end
