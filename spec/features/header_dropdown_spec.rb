require 'rails_helper'

RSpec.feature "HeaderDropdown", type: :feature do
  let(:user) { FactoryBot.create(:user) }

  scenario 'dropdown opens and closes via click and Escape', js: true do
    login_as(user, scope: :user)
    visit root_path
    toggle = find('.profile-toggle')
    toggle.click
    expect(page).to have_css('.profile-dropdown.open')
    expect(page).to have_selector('.profile-menu', visible: true)

  page.execute_script("document.dispatchEvent(new KeyboardEvent('keydown', {key: 'Escape'}));")
    expect(page).not_to have_css('.profile-dropdown.open')
    toggle.click
    expect(page).to have_css('.profile-dropdown.open')
    find('body').click
    expect(page).not_to have_css('.profile-dropdown.open')
  end
end
