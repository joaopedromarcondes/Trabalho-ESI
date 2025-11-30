class User < ApplicationRecord
  has_many :audio_submissions
  has_many :photos
  has_many :noise_measurements
  has_many :health_symptoms, dependent: :destroy
  has_one_attached :avatar

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :name, presence: true
  validates :bio, length: { maximum: 500 }
end
