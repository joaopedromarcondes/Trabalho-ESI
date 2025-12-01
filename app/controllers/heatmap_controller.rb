class HeatmapController < ApplicationController
  def show
    generator =
      case params[:mode]
      when "grid" then HeatmapGridGenerator.new
      when "cluster" then HeatmapClusterGenerator.new
      when "hybrid" then HeatmapHybridGenerator.new
      else HeatmapGridGenerator.new
      end

    render json: generator.generate
  end
end
