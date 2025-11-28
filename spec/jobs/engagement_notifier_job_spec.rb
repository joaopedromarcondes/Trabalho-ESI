require 'rails_helper'

RSpec.describe 'EngagementNotifier enqueueing', type: :job do
  include ActiveJob::TestHelper

  before do
    ActiveJob::Base.queue_adapter = :test
    ENV['APP_HOST'] ||= 'test.host'
  end

  it 'enfileira o ActionMailer job quando executado' do
    user = FactoryBot.create(:user, confirmed_at: Time.current)
    EngagementNotifier.notificacao_perms[user.email] = true

    expect {
      EngagementNotifier.run_daily
    }.to have_enqueued_job(EngagementReminderJob).with(user.id)
  end
end
