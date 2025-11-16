require 'rails_helper'

RSpec.feature "UserActivityGrid", type: :feature do
  let(:user) { FactoryBot.create(:user) }

  before do
    4.times { FactoryBot.create(:photo, user: user) }
  end

  scenario 'photos render in a responsive grid' do
    login_as(user, scope: :user)
    visit users_activity_path
    expect(page).to have_css('.photo-grid')
    expect(page).to have_css('.photo-cell', count: 4)
  end
end
