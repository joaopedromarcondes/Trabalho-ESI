require 'rails_helper'

RSpec.describe User, type: :model do
  it 'valida formato de e-mail inválido' do
    user = FactoryBot.build(:user, email: 'invalid-email')
    expect(user).not_to be_valid
    expect(user.errors[:email]).to be_present
  end

  it 'valida confirmação de senha' do
    user = FactoryBot.build(:user, password: '123456', password_confirmation: '654321')
    expect(user).not_to be_valid
    expect(user.errors[:password_confirmation]).to be_present
  end

  it 'gera token de reset de senha' do
    user = FactoryBot.create(:user)
    token = user.send(:set_reset_password_token)
    expect(token).to be_present
    expect(user.reset_password_token).to be_present
  end

  it 'valido com atributos certos' do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end
end
