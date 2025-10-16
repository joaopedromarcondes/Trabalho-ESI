class AudioSubmission
  include ActiveModel::Model

  attr_accessor :duration_seconds, :latitude, :longitude, :audio_attached

  validates :duration_seconds, presence: true
  validate :duration_within_limit
  validate :location_presence
  validate :audio_presence

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
    unless audio_attached
      errors.add(:audio, 'é obrigatório')
    end
  end
end
