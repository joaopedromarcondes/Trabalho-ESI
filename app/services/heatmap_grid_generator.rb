class HeatmapGridGenerator
  GRID_SIZE = 0.01 # em graus

  def initialize
  end

  def generate
    measurements = NoiseMeasurement.all

    grouped = measurements.group_by do |m|
      lat = (m.latitude / GRID_SIZE).floor * GRID_SIZE
      lon = (m.longitude / GRID_SIZE).floor * GRID_SIZE
      [lat, lon]
    end

    grouped.map do |(lat, lon), points|
      {
        latitude: lat.round(6),
        longitude: lon.round(6),
        level: points.map(&:level).sum / points.size
      }
    end
  end
end
