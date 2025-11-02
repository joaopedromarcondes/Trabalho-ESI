require 'rails_helper'

RSpec.describe 'User registrations', type: :request do
  it 'cria usuário e mostra mensagem de confirmação' do
    ActionMailer::Base.deliveries.clear

    expect {
      post user_registration_path, params: {
        user: { name: 'Teste', email: 'novo@example.com', password: '123456', password_confirmation: '123456' }
      }
    }.to change(User, :count).by(1)

    follow_redirect!
    expect(response.body).to include('Uma mensagem com um link de confirmação')
  end
end
