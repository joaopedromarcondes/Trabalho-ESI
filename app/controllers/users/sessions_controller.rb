class Users::SessionsController < Devise::SessionsController
  def create
    self.resource = warden.authenticate(auth_options)

    if resource.nil?
      super
      return
    end

    unless resource.confirmed?
      set_flash_message! :alert, :unconfirmed if is_flashing_format?
      redirect_to new_user_session_path and return
    end

    super
  rescue StandardError => e
    Rails.logger.error("SessionsController#create error: #{e.class} #{e.message}\n#{e.backtrace.first(10).join('\n')}")
    redirect_to new_user_session_path, alert: I18n.t('devise.failure.unexpected_error', default: 'Erro ao tentar efetuar login.')
  end
end
