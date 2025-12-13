class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('FROM_EMAIL', 'noreply@sendgrid.net')
  layout 'mailer'
end
