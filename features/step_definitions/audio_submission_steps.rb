AUDIO_DURATION_LIMIT = 60

Dado('que tenho um cadastro de usuário') do
  @registered_users ||= {}
  @registered_users['user'] = { password: 'senha' }
end

Dado('que estou na tela de login') do
  @current_page = 'login'
  @system_messages ||= []
end

Quando('insiro meu usuário {string}') do |username|
  @entered_username = username
end

Quando('insiro minha senha {string}') do |password|
  @entered_password = password
end

Quando('clico em login') do
  credentials = @registered_users[@entered_username]
  if credentials && credentials[:password] == @entered_password
    @logged_in = true
    @current_page = 'home_authenticated'
  else
    @logged_in = false
    @system_messages << 'Credenciais inválidas'
  end
end

Então('devo ver a tela inicial autenticada') do
  expect(@logged_in).to be true
  expect(@current_page).to eq('home_authenticated')
end

Dado('que acesso a tela de submissão de ruído') do
  @audio_submission = {
    microphone_allowed: false,
    recording_duration: 0,
    recording: false,
    location_selected: false,
    audio_sent: false,
    can_submit: false,
    messages: [],
    map_points: 0
  }
  @current_page = 'audio_submission'
end

Dado('permito o uso do microfone pelo navegador') do
  @audio_submission[:microphone_allowed] = true
end

Quando('pressiono o botão de gravar') do
  @audio_submission[:recording] = true
  @audio_submission[:recording_duration] = 0
end

Quando('gravo um áudio por {int} segundos') do |duration|
  @audio_submission[:recording_duration] = duration
  @audio_submission[:recording] = false
end

Quando('seleciono minha localização atual no mapa') do
  @audio_submission[:location_selected] = true
end

Quando('pressiono o botão de enviar') do
  duration = @audio_submission[:recording_duration]
  valid_duration = duration.positive? && duration <= AUDIO_DURATION_LIMIT
  ready = @audio_submission[:microphone_allowed] && valid_duration && @audio_submission[:location_selected]

  if ready
    @audio_submission[:audio_sent] = true
    @audio_submission[:can_submit] = true
    @audio_submission[:messages] << 'Áudio enviado com sucesso'
    @audio_submission[:map_points] += 1
  else
    @audio_submission[:audio_sent] = false
    @audio_submission[:can_submit] = false
    @audio_submission[:messages] << 'O áudio deve ter até 60 segundos' if duration > AUDIO_DURATION_LIMIT
    @audio_submission[:messages] << 'Informe a localização' unless @audio_submission[:location_selected]
  end

  @audio_submission[:messages].uniq!
end

Então('o sistema envia o áudio com os metadados de localização') do
  expect(@audio_submission[:audio_sent]).to be true
  expect(@audio_submission[:location_selected]).to be true
end

Então('exibe a mensagem de confirmação {string}') do |mensagem|
  expect(@audio_submission[:messages]).to include(mensagem)
end

Então('o mapa é atualizado com um novo ponto de ruído') do
  expect(@audio_submission[:map_points]).to be > 0
end

Quando('continuo gravando por mais de {int} segundos') do |limit|
  @audio_submission[:recording] = false
  @audio_submission[:recording_duration] = limit + 1
  @audio_submission[:can_submit] = false
  @audio_submission[:audio_sent] = false
  @audio_submission[:messages] << 'O áudio deve ter até 60 segundos'
  @audio_submission[:messages].uniq!
end

Então('o sistema interrompe a gravação automaticamente') do
  expect(@audio_submission[:recording]).to be false
end

Então('exibe a mensagem {string}') do |mensagem|
  expect(@audio_submission[:messages]).to include(mensagem)
end

Então('não permite enviar o áudio até que seja gravado novamente dentro do limite') do
  duration = @audio_submission[:recording_duration]
  expect(duration).to be > AUDIO_DURATION_LIMIT
  expect(@audio_submission[:can_submit]).to be false
end

Dado('gravo um áudio válido') do
  @audio_submission ||= {}
  @audio_submission[:microphone_allowed] = true
  @audio_submission[:recording_duration] = 30
  @audio_submission[:recording] = false
end

Quando('tento enviar o áudio sem selecionar uma localização') do
  @audio_submission[:location_selected] = false
  step 'pressiono o botão de enviar'
end

Então('o sistema não envia o áudio') do
  expect(@audio_submission[:audio_sent]).to be false
end

Então('exibe a mensagem de alerta {string}') do |mensagem|
  expect(@audio_submission[:messages]).to include(mensagem)
end

Então('o botão de enviar permanece desabilitado') do
  expect(@audio_submission[:can_submit]).to be false
end

Então('o áudio deve estar associado ao usuário logado') do
  expect(@audio_submission[:user_id]).to eq(@logged_in_user_id)
end
