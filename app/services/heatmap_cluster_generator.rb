class HeatmapClusterGenerator
  CLUSTER_DISTANCE = 0.01 # ~1km

  def initialize
  end

  def generate
    measurements = NoiseMeasurement.all.to_a
    clusters = []

    until measurements.empty?
      seed = measurements.shift
      cluster = [seed]

      measurements.reject! do |m|
        if distance(seed, m) <= CLUSTER_DISTANCE
          cluster << m
          true
        else
          false
        end
      end

      clusters << cluster
    end

    clusters.map do |cluster|
      {
        latitude: cluster.map(&:latitude).sum / cluster.size,
        longitude: cluster.map(&:longitude).sum / cluster.size,
        level: cluster.map(&:level).sum / cluster.size
      }
    end
  end

  private

  def distance(a, b)
    Math.sqrt((a.latitude - b.latitude)**2 + (a.longitude - b.longitude)**2)
  end
end
