require 'rails_helper'

RSpec.describe "Users::Profiles", type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { FactoryBot.create(:user, password: 'password', confirmed_at: Time.current) }

  before do
    sign_in user
  end

  it 'exibe o checkbox de notificações na edição de perfil' do
    get edit_user_registration_path
    expect(response.body).to include('Receber notificações diárias por e-mail')
  end

  it 'persiste daily_notifications quando o usuário atualiza o perfil' do
    patch users_profile_path, params: { user: { daily_notifications: false, name: user.name } }
    expect(response).to redirect_to(edit_user_registration_path)
    expect(user.reload.daily_notifications).to be_falsey
  end
end
