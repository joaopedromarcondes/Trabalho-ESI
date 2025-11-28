require 'rails_helper'
include Warden::Test::Helpers

RSpec.feature 'Preferência de notificações diárias', type: :feature do
  include ActiveJob::TestHelper

  before do
    Warden.test_mode!
    ActionMailer::Base.deliveries.clear
    ActiveJob::Base.queue_adapter = :test
    Capybara.current_driver = :rack_test
  end

  after do
    Warden.test_reset!
  end

  scenario 'usuário desativa notificações diárias e não recebe e-mail' do
    user = FactoryBot.create(:user, confirmed_at: Time.current)
    login_as(user, scope: :user)

    visit edit_user_registration_path

    uncheck 'user_daily_notifications'
    click_button 'Atualizar Perfil'

    expect(user.reload.daily_notifications).to be_falsey

    perform_enqueued_jobs do
      EngagementNotifier.run_daily
    end

    deliveries = ActionMailer::Base.deliveries.select { |m| m.to && m.to.include?(user.email) }
    expect(deliveries).to be_empty
  end
end
