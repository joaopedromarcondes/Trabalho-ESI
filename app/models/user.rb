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

  def owned_avatars
    raw = read_attribute(:owned_avatars)
    return [] if raw.blank?
    JSON.parse(raw) rescue []
  end

  def owned_avatars=(arr)
    write_attribute(:owned_avatars, arr.to_json)
  end

  after_initialize do
    if read_attribute(:owned_avatars).nil?
      write_attribute(:owned_avatars, [].to_json)
    end

    if has_attribute?(:owned_upgrades) && read_attribute(:owned_upgrades).nil?
      write_attribute(:owned_upgrades, [].to_json)
    end
  end

  def owned_upgrades
    return [] unless has_attribute?(:owned_upgrades)
    raw = read_attribute(:owned_upgrades)
    return [] if raw.blank?
    JSON.parse(raw) rescue []
  end

  def owned_upgrades=(arr)
    return unless has_attribute?(:owned_upgrades)
    write_attribute(:owned_upgrades, arr.to_json)
  end

  def own_upgrade!(key)
    return unless has_attribute?(:owned_upgrades)

    upgrades = owned_upgrades
    return if upgrades.include?(key)

    upgrades << key
    self.owned_upgrades = upgrades
    save if persisted?
  end

  def own_avatar!(key)
    avatars = owned_avatars
    return if avatars.include?(key)

    avatars << key
    self.owned_avatars = avatars
    save if persisted?
  end

  def select_pending_avatar!(key)
    self.pending_avatar = key
    save if persisted?
  end

  def apply_pending_avatar!
    return unless pending_avatar
    self.current_avatar = pending_avatar
    self.pending_avatar = nil
    save if persisted?
  end

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

  def daily_notifications_enabled?
    daily_notifications == true
  end

end
