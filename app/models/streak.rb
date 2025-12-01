class Streak < ApplicationRecord
  belongs_to :user

  ACTIVITY_TYPES = %w[contribuicao medida_ruido foto].freeze
  MILESTONES = [7, 14, 30, 60, 90, 100, 365].freeze

  validates :tipo_atividade, inclusion: { in: ACTIVITY_TYPES }
  validates :user_id, uniqueness: { scope: :tipo_atividade }, if: :user_id
  validates :sequencia_atual, :maior_sequencia, numericality: { greater_than_or_equal_to: 0 }

  scope :with_activity, -> { where('sequencia_atual > 0').order(sequencia_atual: :desc) }

  def atualizar_sequencia(data_contribuicao = Date.today)
    contador = ContadorDeContribuicoes.new(
      sequencia_atual: sequencia_atual > 0 ? sequencia_atual : nil,
      ultimo_registro: ultimo_registro
    )
    contador.registrar_contribuicao(data_contribuicao)

    self.sequencia_atual = contador.sequencia
    self.maior_sequencia = contador.sequencia if contador.sequencia > maior_sequencia
    self.ultimo_registro = data_contribuicao
    save!

    contador
  end

  def atingiu_marco?
    MILESTONES.include?(sequencia_atual)
  end

  def ativa?
    ultimo_registro.present? && ultimo_registro >= Date.today - 1
  end

  def humanized_activity_type
    case tipo_atividade
    when 'contribuicao' then 'Contribuição'
    when 'medida_ruido' then 'Medida de Ruído'
    when 'foto' then 'Foto'
    else tipo_atividade
    end
  end
end
