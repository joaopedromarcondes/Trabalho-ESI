class HeatmapsController < ApplicationController
  def index
    # renderiza a página, sem dados
  end

  def data
    # Gera dados dependendo do modo (grid, cluster, etc.)
    mode = params[:mode] || "grid"
    
    generator = case mode
                when "cluster"
                  HeatmapClusterGenerator.new
                when "hybrid"
                  HeatmapHybridGenerator.new
                else
                  HeatmapGridGenerator.new
                end
    
    points = generator.generate

    render json: { points: points }
  end
end
