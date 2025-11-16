require 'rails_helper'

RSpec.feature "UserActivity", type: :feature do
  let(:user) { FactoryBot.create(:user) }

  before do
    FactoryBot.create(:audio_submission, user: user, duration_seconds: 10)
    FactoryBot.create(:photo, user: user, latitude: 1.0, longitude: 2.0)
    FactoryBot.create(:noise_measurement, user: user, latitude: 3.0, longitude: 4.0, level: 60)
  end

  scenario 'visitor sees their activity page' do
    login_as(user, scope: :user)
    visit users_activity_path

    expect(page).to have_content('Minha Atividade')
    expect(page).to have_content('Áudios enviados')
    expect(page).to have_content('Fotos enviadas')
    expect(page).to have_content('Medições de ruído')
  end
end
