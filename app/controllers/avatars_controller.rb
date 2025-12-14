class AvatarsController < ApplicationController
  before_action :authenticate_user!

  def index
    @catalog = AvatarService.default_catalog
  end

  def acquire
    key = params[:key]
    service = AvatarService.new(current_user, AvatarService.default_catalog)
    result = service.acquire(key)
    flash[:notice] = 'Avatar adquirido' if result == :approved
    flash[:alert] = 'Avatar inválido ou já possuído' unless result == :approved
    redirect_back fallback_location: root_path
  end

  def select
    key = params[:key]
    service = AvatarService.new(current_user, AvatarService.default_catalog)
    result = service.select(key)
    flash[:notice] = 'Avatar selecionado (aguardando confirmação)' if result == :ok
    flash[:alert] = 'Avatar não possuído' if result == :not_owned
    redirect_back fallback_location: edit_user_registration_path
  end

  def confirm
    service = AvatarService.new(current_user, AvatarService.default_catalog)
    result = service.confirm_profile_update
    flash[:notice] = 'Avatar aplicado ao perfil' if result == :applied
    redirect_to edit_user_registration_path
  end
end
