class EngagementMailer < ApplicationMailer
  def daily_reminder(user)
    @user = user
    @home = Rails.application.routes.url_helpers.root_url(host: ENV['APP_HOST'], protocol: 'https')
    mail(to: @user.email, subject: 'Lembrete diário')
  end
end
