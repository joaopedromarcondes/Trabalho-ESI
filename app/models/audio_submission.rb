class AudioSubmission < ApplicationRecord
  belongs_to :user

  has_one_attached :audio

  attr_accessor :audio_attached

  validates :duration_seconds, presence: true
  validate :duration_within_limit
  validate :location_presence
  validate :audio_presence
  validate :audio_duration_presence

  private

  def duration_within_limit
    return if duration_seconds.blank?
    value = duration_seconds.to_i
    if value <= 0 || value > 60
      errors.add(:base, 'O áudio deve ter até 60 segundos')
    end
  end

  def location_presence
    if latitude.blank? || longitude.blank?
      errors.add(:base, 'Informe a localização')
    end
  end

  def audio_presence
    unless audio.attached? || audio_attached
      errors.add(:audio, 'é obrigatório')
    end
  end

  def audio_duration_presence
    if duration_seconds.blank?
      errors.add(:duration_seconds, 'não pode ficar em branco')
    end
  end
end
