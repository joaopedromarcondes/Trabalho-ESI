class HomeController < ApplicationController
  def index
    @photos = Photo.all
  end
  # Retorna as medições de ruído em formato JSON
  def noise_data
    render json: NoiseMeasurement.all.select(:latitude, :longitude, :level)
  end
end
