require 'rails_helper'

RSpec.describe EngagementNotifier, type: :model do
  before do
    ActionMailer::Base.deliveries.clear
    described_class.notificacao_perms.clear
    described_class.sent_notifications.clear
    ENV['APP_HOST'] ||= 'test.host'
  end

  describe '.run_daily' do
    it 'sends email to confirmed users with permission' do
      user = FactoryBot.create(:user, confirmed_at: Time.current)
      described_class.notificacao_perms[user.email] = true

      described_class.run_daily

      deliveries = ActionMailer::Base.deliveries.select { |m| m.to && m.to.include?(user.email) }
      expect(deliveries.size).to eq(1)
      expect(described_class.sent_notifications[user.email]).to eq(Date.today)
    end

    it 'does not send when permission is false' do
      user = FactoryBot.create(:user, confirmed_at: Time.current)
      described_class.notificacao_perms[user.email] = false

      described_class.run_daily

      deliveries = ActionMailer::Base.deliveries.select { |m| m.to && m.to.include?(user.email) }
      expect(deliveries).to be_empty
      expect(described_class.sent_notifications[user.email]).to be_nil
    end

    it 'does not resend if already sent today' do
      user = FactoryBot.create(:user, confirmed_at: Time.current)
      described_class.notificacao_perms[user.email] = true
      described_class.sent_notifications[user.email] = Date.today

      described_class.run_daily

      deliveries = ActionMailer::Base.deliveries.select { |m| m.to && m.to.include?(user.email) }
      expect(deliveries).to be_empty
    end
  end
end
