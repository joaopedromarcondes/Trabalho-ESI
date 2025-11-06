class HealthSymptom < ApplicationRecord
  validates :sintoma, presence: true, length: { maximum: 255 }

  enum :intensidade, { leve: 0, moderado: 1, alto: 2 }

  validates :intensidade, presence: true
end
