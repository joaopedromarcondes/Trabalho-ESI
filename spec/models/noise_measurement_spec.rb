require 'rails_helper'

RSpec.describe NoiseMeasurement, type: :model do
  describe 'validações' do
    it { should validate_presence_of(:latitude) }
    it { should validate_presence_of(:longitude) }
    it { should validate_presence_of(:level) }
  end

  describe '#localizacao' do
    it 'retorna string formatada com lat/lon' do
      m = NoiseMeasurement.new(latitude: -23.561, longitude: -46.656, level: 75)
      expect(m.localizacao).to eq('(-23.561, -46.656)')
    end
  end
end
