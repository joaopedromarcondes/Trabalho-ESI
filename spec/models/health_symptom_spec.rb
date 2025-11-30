require 'rails_helper'

RSpec.describe HealthSymptom, type: :model do
  subject { FactoryBot.build(:health_symptom) }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it "is not valid without a user" do
    sintoma = build(:health_symptom, user: nil)
    expect(sintoma).not_to be_valid
    expect(sintoma.errors[:user]).to include("é obrigatório(a)") 
  end

  it 'is not valid without a sintoma' do
    subject.sintoma = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without an intensidade' do
    subject.intensidade = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid with an intensidade outside the allowed range' do
    expect { subject.intensidade = :inexistente }.to raise_error(ArgumentError)
  end

  it 'is valid with minimum intensidade' do
    subject.intensidade = :leve
    expect(subject).to be_valid
  end

  it 'is valid with medium intensidade' do
    subject.intensidade = :moderado
    expect(subject).to be_valid
  end

  it 'is valid with maximum intensidade' do
    subject.intensidade = :alto
    expect(subject).to be_valid
  end

  it 'is not valid sintoma too long' do
    subject.sintoma = 'a' * 256
    expect(subject).not_to be_valid
  end
end
