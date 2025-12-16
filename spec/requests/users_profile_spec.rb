require 'rails_helper'

RSpec.describe "Users::Profiles", type: :request do
  let(:user) { FactoryBot.create(:user, password: 'password123', confirmed_at: Time.current) }

  before do
    post user_session_path, params: { 
      user: { email: user.email, password: 'password123' } 
    }
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
