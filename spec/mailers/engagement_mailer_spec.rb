require 'rails_helper'

RSpec.describe EngagementMailer, type: :mailer do
  describe '#daily_reminder' do
    let(:user) { FactoryBot.create(:user, name: 'Ana', confirmed_at: Time.current) }

    before do
      ENV['APP_HOST'] ||= 'test.host'
      ENV['SMTP_USERNAME'] ||= 'grupo03esi2025@gmail.com'
    end

    it 'monta o e-mail com subject, destinatário e remetente corretos e inclui link para home' do
      mail = EngagementMailer.daily_reminder(user)

      expect(mail.subject).to eq('Lembrete diário')
      expect(mail.to).to include(user.email)
      expect(mail.from).to include(ENV['SMTP_USERNAME'])
      expect(mail.body.encoded).to match(Rails.application.routes.url_helpers.root_url(host: ENV['APP_HOST'], protocol: 'https'))
    end
  end
end
