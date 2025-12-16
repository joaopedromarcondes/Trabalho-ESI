require 'rails_helper'

RSpec.describe EngagementMailer, type: :mailer do
  describe '#daily_reminder' do
    let(:user) { FactoryBot.create(:user, name: 'Ana', confirmed_at: Time.current) }

    it 'monta o e-mail com subject, destinatário e remetente corretos e inclui link para home' do
      mail = EngagementMailer.daily_reminder(user)

      expect(mail.subject).to eq('Lembrete diário')
      expect(mail.to).to include(user.email)
      expect(mail.from).not_to be_empty
      expect(mail.body.encoded).to match(%r{https?://[^\s]+})
    end
  end
end
