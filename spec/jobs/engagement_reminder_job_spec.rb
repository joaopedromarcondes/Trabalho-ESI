require 'rails_helper'

RSpec.describe EngagementReminderJob, type: :job do
  include ActiveJob::TestHelper

  before do
    ActiveJob::Base.queue_adapter = :test
    ActionMailer::Base.deliveries.clear
    ENV['APP_HOST'] ||= 'test.host'
  end

  it 'envia o e-mail e atualiza last_engagement_sent_at' do
    user = create(:user, confirmed_at: Time.current)

    perform_enqueued_jobs do
      EngagementReminderJob.perform_later(user.id)
    end

    deliveries = ActionMailer::Base.deliveries.select { |m| m.to && m.to.include?(user.email) }
    expect(deliveries.size).to eq(1)
    expect(user.reload.last_engagement_sent_at).to be_present
  end

  it 'não atualiza last_engagement_sent_at se a entrega falhar' do
    user = create(:user, confirmed_at: Time.current)

    allow(EngagementMailer).to receive(:daily_reminder).and_raise(Net::SMTPAuthenticationError.new('auth error'))

    begin
      EngagementReminderJob.new.perform(user.id)
    rescue Net::SMTPAuthenticationError
    end

    expect(user.reload.last_engagement_sent_at).to be_nil
  end
end
