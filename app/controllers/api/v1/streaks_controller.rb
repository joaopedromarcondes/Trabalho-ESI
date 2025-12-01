module Api
  module V1
    class StreaksController < ApplicationController
      before_action :authenticate_user!
      before_action :set_streak, only: [:show, :update]

      # GET /api/v1/streaks
      def index
        @streaks = current_user.streaks.order(sequencia_atual: :desc)
        render json: {
          streaks: @streaks.as_json(only: [:id, :tipo_atividade, :sequencia_atual, :maior_sequencia, :ultimo_registro]),
          total_sequencia: current_user.sequencia_total,
          maior_sequencia_geral: current_user.maior_sequencia_geral,
          proximos_marcos: current_user.proximos_marcos
        }
      end

      # GET /api/v1/streaks/:id
      def show
        render json: @streak.as_json(
          only: [:id, :tipo_atividade, :sequencia_atual, :maior_sequencia, :ultimo_registro, :ativa],
          methods: [:atingiu_marco?, :dias_sem_atividade]
        )
      end

      # POST /api/v1/streaks/:id/registrar
      def registrar_contribuicao
        @streak = current_user.obter_ou_criar_sequencia(params[:tipo_atividade])
        contador = @streak.atualizar_sequencia
        
        render json: {
          streak: @streak.as_json(only: [:sequencia_atual, :maior_sequencia]),
          mensagem: contador.mensagem,
          atingiu_marco: @streak.atingiu_marco?
        }, status: :ok
      end

      # POST /api/v1/streaks/resetar/:tipo_atividade
      def resetar
        @streak = current_user.obter_ou_criar_sequencia(params[:tipo_atividade])
        @streak.resetar_sequencia
        
        render json: { message: 'Sequência reiniciada' }, status: :ok
      end

      private

      def set_streak
        @streak = current_user.streaks.find(params[:id])
      end
    end
  end
end
