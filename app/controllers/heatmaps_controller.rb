class HeatmapsController < ApplicationController
  def show
    mode = params[:mode] || "grid"

    generator = case mode
                when "grid" then HeatmapGridGenerator.new
                when "cluster" then HeatmapClusterGenerator.new
                when "hybrid" then HeatmapHybridGenerator.new
                else
                  return render json: { error: "Modo inválido: #{mode}" }, status: :bad_request
                end

    result = generator.generate

    render json: {
      mode: mode,
      generated_at: Time.now.utc,
      points: result
    }
  end
end
