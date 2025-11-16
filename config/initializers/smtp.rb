if ENV['SMTP_ADDRESS'].present?
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.perform_deliveries = true
  ActionMailer::Base.raise_delivery_errors = true
  ActionMailer::Base.smtp_settings = {
    address:              ENV['SMTP_ADDRESS'],
    port:                 (ENV['SMTP_PORT'] || 587).to_i,
    domain:               ENV['SMTP_DOMAIN'],
    user_name:            ENV['SMTP_USERNAME'],
    password:             ENV['SMTP_PASSWORD'],
    authentication:       (ENV['SMTP_AUTHENTICATION'] || 'plain').to_sym,
    enable_starttls_auto: ENV.fetch('SMTP_ENABLE_STARTTLS_AUTO', 'true') == 'true'
  }
  ActionMailer::Base.default_url_options = { host: ENV.fetch('APP_HOST', 'example.com'), protocol: 'https' }
end
