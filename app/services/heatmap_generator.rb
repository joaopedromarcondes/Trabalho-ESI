# Serviço responsável por gerar o conjunto de dados para o mapa de calor de ruído.

class HeatmapGenerator
  def generate
    NoiseMeasurement.all.map do |m|
      {
        latitude: m.latitude,
        longitude: m.longitude,
        level: m.level
      }
    end
  end
end
