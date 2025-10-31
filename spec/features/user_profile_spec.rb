require 'rails_helper'

RSpec.describe 'User profile management', type: :feature do
  let(:user) { create(:user, email: 'test@example.com', password: 'password123', name: 'Test User') }
  
  before do
    sign_in user
    visit edit_user_registration_path
  end

  it 'allows user to update their name' do
    fill_in 'Nome', with: 'New Name'
    fill_in 'Senha atual', with: 'password123'
    click_button 'Salvar alterações'
    
    expect(page).to have_content('Olá, New Name!')
  end

  it 'allows user to update their bio' do
    fill_in 'Biografia', with: 'My new bio'
    fill_in 'Senha atual', with: 'password123'
    click_button 'Salvar alterações'
    
    expect(user.reload.bio).to eq('My new bio')
  end

  it 'shows email field as readonly' do
    email_field = find_field('E-mail (não editável)')
    expect(email_field).to be_disabled
    expect(email_field.value).to eq(user.email)
  end

  it 'allows password change with current password' do
    fill_in 'Nova senha', with: 'newpassword123'
    fill_in 'Confirme a nova senha', with: 'newpassword123'
    fill_in 'Senha atual', with: 'password123'
    click_button 'Salvar alterações'
    
    expect(page).to have_content('Seu perfil foi atualizado com sucesso')
  end
end