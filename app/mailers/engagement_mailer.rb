class EngagementMailer < ApplicationMailer
  def daily_reminder(user)
    @user = user
    host = ENV['APP_HOST'] || ActionMailer::Base.default_url_options[:host]
    protocol = Rails.env.production? ? 'https' : 'http'
    @home = Rails.application.routes.url_helpers.root_url(host: host, protocol: protocol)
    mail(to: @user.email, subject: 'Lembrete diário')
  end
end
