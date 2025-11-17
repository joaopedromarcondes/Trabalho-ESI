class HeatmapClusterGenerator
  def initialize(locations, max_distance: 0.01)
    @locations = locations
    @max_distance = max_distance
  end

  def generate
    return [] if @locations.empty?

    clusters = []

    @locations.each do |loc|
      found_cluster = false

      clusters.each do |c|
        if distance(c[:centroid], loc) <= @max_distance
          c[:points] << loc
          c[:centroid] = recompute_centroid(c[:points])
          found_cluster = true
          break
        end
      end

      clusters << { centroid: loc, points: [loc] } unless found_cluster
    end

    clusters
  end

  private

  def distance(a, b)
    Math.sqrt((a.latitude - b.latitude)**2 + (a.longitude - b.longitude)**2)
  end

  def recompute_centroid(points)
    lat = points.map(&:latitude).sum / points.length
    lng = points.map(&:longitude).sum / points.length
    OpenStruct.new(latitude: lat, longitude: lng)
  end
end
