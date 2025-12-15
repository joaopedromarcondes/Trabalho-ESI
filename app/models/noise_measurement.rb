# Modelo que representa uma medição de ruído ambiental
class NoiseMeasurement < ApplicationRecord
  belongs_to :user
  validates :latitude, :longitude, :level, presence: true
  validates :level, numericality: true

  def localizacao
    "(#{latitude}, #{longitude})"
  end
end
# Serviço responsável por gerar o conjunto de dados para o mapa de calor de ruído.
# Possui latitude, longitude e level (em dB)
