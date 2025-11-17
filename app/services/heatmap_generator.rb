# Serviço responsável por gerar o conjunto de dados para o mapa de calor de ruído.

class HeatmapGenerator
  # Retorna dados agregados para gerar o heatmap inicial (SCRUM-1)
  def generate
    measurements = NoiseMeasurement.all

    # Mapear cada medição diretamente
    measurements.map do |m|
      {
        latitude: m.latitude,
        longitude: m.longitude,
        level: m.level
      }
    end
  end
end
