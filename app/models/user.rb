class User < ApplicationRecord
  has_many :audio_submissions
  has_many :photos
  has_many :noise_measurements
  has_many :health_symptoms, dependent: :destroy
  has_many :streaks, dependent: :destroy
  has_one_attached :avatar

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :name, presence: true
  validates :bio, length: { maximum: 500 }

  def obter_ou_criar_sequencia(tipo_atividade = 'contribuicao')
    streaks.find_or_create_by(tipo_atividade: tipo_atividade)
  end

  def atualizar_sequencia_atividade(tipo_atividade = 'contribuicao', data = Date.today)
    obter_ou_criar_sequencia(tipo_atividade).atualizar_sequencia(data)
  end

  def sequencia_total
    streaks.sum(:sequencia_atual)
  end

  def maior_sequencia_geral
    streaks.maximum(:maior_sequencia) || 0
  end

  def todas_as_sequencias
    streaks.order(sequencia_atual: :desc)
  end
end
