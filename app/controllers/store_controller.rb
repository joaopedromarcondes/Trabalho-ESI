class StoreController < ApplicationController
  before_action :authenticate_user!

  def index
    @catalog = UpgradeService.default_catalog
  end

  def acquire
    key = params[:key].to_s
    service = UpgradeService.new(current_user, UpgradeService.default_catalog)
    result = service.acquire(key)

    if result == :approved
      flash[:notice] = 'Upgrade adquirido!'
    elsif result == :already_owned
      flash[:alert] = 'Você já tem esse upgrade.'
    else
      flash[:alert] = 'Esse upgrade não existe.'
    end

    redirect_to store_path
  end
end
