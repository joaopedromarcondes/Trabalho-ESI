# Serviço responsável por gerar o conjunto de dados para o mapa de calor de ruído em grid

class HeatmapGridGenerator
  def initialize(locations, grid_size: 10)
    @locations = locations
    @grid_size = grid_size
  end

  def generate
    return [] if @locations.empty?

    min_lat = @locations.map(&:latitude).min
    max_lat = @locations.map(&:latitude).max
    min_lng = @locations.map(&:longitude).min
    max_lng = @locations.map(&:longitude).max

    lat_step = (max_lat - min_lat) / @grid_size.to_f
    lng_step = (max_lng - min_lng) / @grid_size.to_f

    grid = Array.new(@grid_size) { Array.new(@grid_size, 0) }

    @locations.each do |loc|
      lat_index = [( (loc.latitude - min_lat) / lat_step ).floor, @grid_size - 1].min
      lng_index = [( (loc.longitude - min_lng) / lng_step ).floor, @grid_size - 1].min

      grid[lat_index][lng_index] += 1
    end

    grid
  end
end
