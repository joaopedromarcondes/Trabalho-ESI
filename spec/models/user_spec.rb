require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validacoes" do
    it 'valido com atributos certos' do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end
    
    it 'nao eh valido sem um nome' do
      user = FactoryBot.build(:user, name: nil)
      expect(user).to_not be_valid
    end

  end
end
