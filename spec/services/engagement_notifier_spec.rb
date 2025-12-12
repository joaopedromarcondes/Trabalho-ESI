require 'rails_helper'

RSpec.describe EngagementNotifier, type: :model do
  include ActiveJob::TestHelper

  before do
    ActionMailer::Base.deliveries.clear
    described_class.notificacao_perms.clear
    described_class.sent_notifications.clear
    ActiveJob::Base.queue_adapter = :test
    clear_enqueued_jobs
    ENV['APP_HOST'] ||= 'test.host'
  end

  describe '.run_daily' do
    it 'envia e-mail para usuários confirmados com permissão' do
      user = FactoryBot.create(:user, confirmed_at: Time.current)
      described_class.notificacao_perms[user.email] = true

      ActionMailer::Base.deliveries.clear

      perform_enqueued_jobs do
        described_class.run_daily
      end

      deliveries = ActionMailer::Base.deliveries.select do |m| 
        m.to.include?(user.email) && m.subject == "Lembrete diário"
      end
      expect(deliveries.size).to eq(1)
      expect(user.reload.last_engagement_sent_at.to_date).to eq(Date.today)
    end

    it 'não envia quando a permissão está desativada' do
      user = FactoryBot.create(:user, confirmed_at: Time.current)
      described_class.notificacao_perms[user.email] = false

      perform_enqueued_jobs do
        described_class.run_daily
      end

      deliveries = ActionMailer::Base.deliveries.select { |m| m.to && m.to.include?(user.email) }
      expect(deliveries).to be_empty
      expect(user.reload.last_engagement_sent_at).to be_nil
    end

    it 'não reenvia se já foi enviado hoje' do
      user = FactoryBot.create(:user, confirmed_at: Time.current)
      described_class.notificacao_perms[user.email] = true
      user.update!(last_engagement_sent_at: Time.current)

      perform_enqueued_jobs do
        described_class.run_daily
      end

      deliveries = ActionMailer::Base.deliveries.select { |m| m.to && m.to.include?(user.email) }
      expect(deliveries).to be_empty
    end
  end
end
