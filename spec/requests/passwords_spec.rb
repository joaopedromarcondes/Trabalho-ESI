require 'rails_helper'

RSpec.describe 'Password recovery', type: :request do
  it 'envia instruções de reset' do
    user = FactoryBot.create(:user, email: 'recuperar@example.com', confirmed_at: Time.current)
    ActionMailer::Base.deliveries.clear

    post user_password_path, params: { user: { email: user.email } }
    expect(ActionMailer::Base.deliveries.size).to eq(1)
    expect(response).to be_successful.or be_redirect
  end
end
