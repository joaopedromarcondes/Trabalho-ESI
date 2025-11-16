class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('SMTP_USERNAME', 'grupo03esi2025@gmail.com')
  layout 'mailer'
end
