require 'rails_helper'

RSpec.describe AudioSubmission, type: :model do
  def build_submission(attrs = {})
    defaults = { duration_seconds: 30, latitude: -23.5, longitude: -46.6, audio_attached: true }
    AudioSubmission.new(defaults.merge(attrs))
  end

  it 'is valid with duration <= 60, location and audio' do
    sub = build_submission(duration_seconds: 60)
    expect(sub).to be_valid
  end

  it 'is invalid when duration is greater than 60 seconds' do
    sub = build_submission(duration_seconds: 61)
    expect(sub).to be_invalid
    expect(sub.errors.full_messages).to include('O áudio deve ter até 60 segundos')
  end

  it 'is invalid when duration is zero or negative' do
    [0, -1].each do |val|
      sub = build_submission(duration_seconds: val)
      expect(sub).to be_invalid
      expect(sub.errors.full_messages).to include('O áudio deve ter até 60 segundos')
    end
  end

  it 'is invalid without location' do
    sub = build_submission(latitude: nil)
    expect(sub).to be_invalid
    expect(sub.errors.full_messages).to include('Informe a localização')
  end

  it 'is invalid without audio attached' do
    sub = build_submission(audio_attached: false)
    expect(sub).to be_invalid
    expect(sub.errors[:audio]).to include('é obrigatório')
  end
end
