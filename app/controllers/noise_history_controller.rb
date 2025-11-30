class NoiseHistoryController < ApplicationController
  def index
    @noise_measurements = NoiseMeasurement.all
    if params[:start_date].present?
      start_datetime = Date.parse(params[:start_date]).beginning_of_day
      @noise_measurements = @noise_measurements.where("created_at >= ?", start_datetime)
    end
    
    if params[:end_date].present?
      end_datetime = Date.parse(params[:end_date]).end_of_day
      @noise_measurements = @noise_measurements.where("created_at <= ?", end_datetime)
    end
    if params[:lat].present? && params[:lng].present? && params[:radius].present?
      lat = params[:lat].to_f
      lng = params[:lng].to_f
      radius_km = params[:radius].to_f
      lat_range = radius_km / 111.0
      lng_range = radius_km / (111.0 * Math.cos(lat * Math::PI / 180.0))
      
      @noise_measurements = @noise_measurements.where(
        latitude: (lat - lat_range)..(lat + lat_range),
        longitude: (lng - lng_range)..(lng + lng_range)
      )
    end
    

    if @noise_measurements.any?
      @stats = {
        count: @noise_measurements.count,
        average: @noise_measurements.average(:level).to_f.round(1),
        min: @noise_measurements.minimum(:level),
        max: @noise_measurements.maximum(:level)
      }
    else
      @stats = { count: 0, average: 0, min: 0, max: 0 }
    end
    
    respond_to do |format|
      format.html
      format.json do
        render json: {
          measurements: @noise_measurements.as_json(only: [:id, :latitude, :longitude, :level, :created_at]),
          stats: @stats
        }
      end
    end
  end
end
