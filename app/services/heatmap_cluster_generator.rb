class HeatmapClusterGenerator
  K = 5 # número de clusters

  def generate
    points = NoiseMeasurement.all.map { |n| [n.latitude, n.longitude, n.level] }
    return [] if points.empty?

    centroids = points.sample(K)

    5.times do
      clusters = Hash.new { |h, k| h[k] = [] }

      points.each do |p|
        closest = centroids.min_by { |c| distance(p, c) }
        clusters[closest] << p
      end

      centroids = clusters.map do |c, pts|
        lat = pts.sum { |p| p[0] } / pts.size
        lng = pts.sum { |p| p[1] } / pts.size
        lvl = pts.sum { |p| p[2] } / pts.size
        [lat, lng, lvl]
      end
    end

    centroids.map do |c|
      { latitude: c[0], longitude: c[1], level: c[2].round }
    end
  end

  private

  def distance(a, b)
    Math.sqrt((a[0]-b[0])**2 + (a[1]-b[1])**2)
  end
end
