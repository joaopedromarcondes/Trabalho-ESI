class ContadorDeContribuicoes
  attr_reader :sequencia, :mensagem

  MILESTONES = [7, 14, 30, 60, 90, 100, 365].freeze

  def initialize(sequencia_atual: nil, ultimo_registro: nil)
    @sequencia_atual = sequencia_atual
    @ultimo_registro = ultimo_registro
    @sequencia = sequencia_atual || 0
    @mensagem = ""
  end

  def registrar_contribuicao(data_contribuicao)
    if @sequencia_atual.nil?
      handle_first_contribution
    elsif same_day?(data_contribuicao)
      handle_same_day_contribution
    elsif consecutive_day?(data_contribuicao)
      handle_consecutive_day_contribution
    else
      handle_broken_streak
    end
  end

  private

  def same_day?(data)
    @ultimo_registro == data
  end

  def consecutive_day?(data)
    @ultimo_registro == data - 1
  end

  def handle_first_contribution
    @sequencia = 1
    @mensagem = "Parabéns! Este foi seu primeiro dia contribuindo!"
  end

  def handle_same_day_contribution
    @sequencia = @sequencia_atual || 0
    @mensagem = "Obrigado pela contribuição! Sua sequência de dias continua igual por hoje! Volte amanhã para aumentar sua sequência."
  end

  def handle_consecutive_day_contribution
    @sequencia = (@sequencia_atual || 0) + 1
    @mensagem = if MILESTONES.include?(@sequencia)
                  "Parabéns! Você atingiu #{@sequencia} dias de sequência! 🎉 Recompensa especial ou destaque para o marco de #{@sequencia} dias"
                else
                  "Você está contribuindo há #{@sequencia} dias! Continue assim!"
                end
  end

  def handle_broken_streak
    @sequencia = 1
    @mensagem = "Parabéns! Você voltou a contribuir, não desista!"
  end
end
