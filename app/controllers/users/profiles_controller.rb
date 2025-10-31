class Users::ProfilesController < ApplicationController
  before_action :authenticate_user!

  def update
    if current_user.update(profile_params)
      bypass_sign_in(current_user)
      redirect_to edit_user_registration_path, notice: 'Perfil atualizado com sucesso!'
    else
      render "devise/registrations/edit"
    end
  end

  private

  def profile_params
    params.require(:user).permit(:name, :bio, :avatar)
  end
end