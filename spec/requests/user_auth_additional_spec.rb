require 'rails_helper'

RSpec.describe 'User auth edge cases', type: :request do
  it 'não permite login de usuário não confirmado' do
    user = FactoryBot.create(:user, confirmed_at: nil, email: 'unconfirmed@example.com', password: '123456')

    post user_session_path, params: { user: { email: user.email, password: '123456' } }
    begin
      follow_redirect!
    rescue StandardError
    end

    body = response.body.to_s
    expect(body).to match(/confirm(ation|ar)?|tem que confirmar|You have to confirm/i)
  end

  it 'mostra erro ao acessar link de reset com token inválido' do
    get edit_user_password_path(reset_password_token: 'invalidtoken')
    body = response.body.to_s
    expect(body).to match(/invalid|inválido|can't access|You can't access this page|não pode acessar/i)
  end

  it 'envia e-mail de reset que contém token no link' do
    user = FactoryBot.create(:user, email: 'tokencheck@example.com', confirmed_at: Time.current)
    ActionMailer::Base.deliveries.clear

    post user_password_path, params: { user: { email: user.email } }
    expect(ActionMailer::Base.deliveries.size).to eq(1)

    email = ActionMailer::Base.deliveries.last
    body = email.respond_to?(:body) ? email.body.to_s : email.to_s
    token = body.match(/reset_password_token=([^\s"]+)/)[1] rescue nil
    expect(token).to be_present
  end
end
