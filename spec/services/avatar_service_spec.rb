require 'rails_helper'

RSpec.describe AvatarService do
  let(:user) { { id: 1, email: 'test@example.com', owned_avatars: [], current_avatar: nil } }
  let(:catalog) { { 'gato' => {}, 'raposa' => {}, 'coelho' => {} } }
  subject { described_class.new(user, catalog) }

  describe '#acquire' do
    context 'quando o avatar existe e não é possuído' do
      it 'aprova a aquisição e aplica como avatar atual' do
        result = subject.acquire('gato')
        expect(result).to eq(:approved)
        expect(user[:owned_avatars]).to include('gato')
        expect(user[:current_avatar]).to eq('gato')
      end
    end

    context 'quando o avatar já é possuído' do
      it 'retorna :already_owned e não duplica a posse' do
        user[:owned_avatars] << 'raposa'
        result = subject.acquire('raposa')
        expect(result).to eq(:already_owned)
        expect(user[:owned_avatars].count('raposa')).to eq(1)
      end
    end

    context 'quando o avatar não existe no catálogo' do
      it 'retorna :invalid_avatar' do
        expect(subject.acquire('desconhecido')).to eq(:invalid_avatar)
      end
    end
  end

  describe '#select' do
    context 'quando o avatar é possuído' do
      it 'aplica o avatar como atual e retorna :ok' do
        user[:owned_avatars] << 'coelho'
        expect(subject.select('coelho')).to eq(:ok)
        expect(user[:current_avatar]).to eq('coelho')
      end
    end

    context 'quando o avatar não é possuído' do
      it 'retorna :not_owned e não altera o avatar atual' do
        expect(subject.select('coelho')).to eq(:not_owned)
        expect(user[:current_avatar]).to be_nil
      end
    end
  end
end
