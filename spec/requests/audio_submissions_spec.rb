require 'rails_helper'

RSpec.describe "AudioSubmissions", type: :request do
  let(:user) { create(:user) }
  before do
    post user_session_path, params: { user: { email: user.email, password: user.password } }
  end
  def uploaded_audio
    Rack::Test::UploadedFile.new(
      Rails.root.join('spec/fixtures/files/audio_teste.mp3'),
      'audio/mpeg'
    )
  end

  def valid_params(overrides = {})
    {
      audio_submission: {
        audio: uploaded_audio,
        latitude: '-23.5',
        longitude: '-46.6',
        duration_seconds: '30'
      }.merge(overrides)
    }
  end

  describe 'POST /audio_submissions' do
    context 'com parâmetros válidos' do
      it 'redireciona para a home com mensagem de sucesso' do
        post '/audio_submissions', params: valid_params
        expect(response).to have_http_status(:found).or have_http_status(:see_other)
        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response.body).to include('Áudio enviado com sucesso')
      end
    end

    context 'com duração maior que 60s' do
      it 'retorna 422 e exibe a mensagem de erro' do
        post '/audio_submissions', params: valid_params(duration_seconds: '61')
  expect(response).to have_http_status(:unprocessable_content)
        expect(response.body).to include('O áudio deve ter até 60 segundos')
      end
    end

    context 'sem localização' do
      it 'retorna 422 e exibe a mensagem de erro' do
        post '/audio_submissions', params: valid_params(latitude: nil)
  expect(response).to have_http_status(:unprocessable_content)
        expect(response.body).to include('Informe a localização')
      end
    end

    context 'sem áudio' do
      it 'retorna 422 e exibe a mensagem de erro' do
        params = valid_params
        params[:audio_submission].delete(:audio)

        post '/audio_submissions', params: params
  expect(response).to have_http_status(:unprocessable_content)
        expect(response.body).to include('é obrigatório')
      end
    end
  end

  describe 'GET /audio_submissions/new' do
    it 'renderiza a página do formulário' do
      get new_audio_submission_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Enviar áudio de ruído')
    end
  end
end
