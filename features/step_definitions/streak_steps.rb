Dado("que o usuário está cadastrado no sistema") do
  @sequencia_atual = nil
  @ultimo_registro = nil
  @contador = nil
  @tipo_atividade = 'contribuicao'
  @maior_sequencia = 0
end

Dado("que o usuário está autenticado") do
  @user = create(:user)
  login_as(@user)
end

Dado("que o usuário possui sequências registradas") do
  @user.obter_ou_criar_sequencia('contribuicao').atualizar_sequencia(Date.today)
  @user.obter_ou_criar_sequencia('medida_ruido').atualizar_sequencia(Date.today)
end

Dado("que o usuário possui uma sequência atual de {int} dias") do |dias|
  @sequencia_atual = dias
  @maior_sequencia = dias
end

Dado("que o usuário possui uma sequência atual de {int} para {string}") do |dias, tipo|
  @sequencia_atual = dias
  @tipo_atividade = tipo
  @maior_sequencia = dias
end

Dado("o último registro de contribuição foi ontem") do
  @ultimo_registro = Date.today - 1
end

Dado("o último registro foi feito ontem") do
  @ultimo_registro = Date.today - 1
end

Dado("o último registro de contribuição foi há {int} dias") do |dias|
  @ultimo_registro = Date.today - dias
end

Dado("que o usuário não possui nenhuma sequência registrada") do
  @sequencia_atual = nil
  @ultimo_registro = nil
  @maior_sequencia = 0
end

Dado("que o usuário realizou uma contribuição hoje") do
  @sequencia_atual ||= 1
  @ultimo_registro = Date.today
end

Quando("o usuário realiza uma nova contribuição hoje") do
  @contador = ContadorDeContribuicoes.new(
    sequencia_atual: @sequencia_atual,
    ultimo_registro: @ultimo_registro
  )
  @contador.registrar_contribuicao(Date.today)
end

Quando("o usuário realiza sua primeira contribuição") do
  @contador = ContadorDeContribuicoes.new(
    sequencia_atual: nil,
    ultimo_registro: nil
  )
  @contador.registrar_contribuicao(Date.today)
end

Quando("o usuário realiza uma nova contribuição no mesmo dia") do
  @contador = ContadorDeContribuicoes.new(
    sequencia_atual: @sequencia_atual,
    ultimo_registro: @ultimo_registro
  )
  @contador.registrar_contribuicao(@ultimo_registro)
end

Quando("o usuário realiza uma nova contribuição de {string} hoje") do |tipo|
  @contador = ContadorDeContribuicoes.new(
    sequencia_atual: @sequencia_atual,
    ultimo_registro: @ultimo_registro
  )
  @contador.registrar_contribuicao(Date.today)
  @tipo_atividade = tipo
end

Quando("o usuário acessa sua página de perfil") do
  visit user_path(@user)
end

Então("o sistema deve aumentar a sequência para {int} dias") do |dias|
  expect(@contador.sequencia).to eq(dias)
end

Então("o sistema deve criar uma nova sequência com valor igual a {int}") do |valor|
  expect(@contador.sequencia).to eq(valor)
end

Então("o sistema deve reiniciar a sequência para {int} dia") do |valor|
  expect(@contador.sequencia).to eq(valor)
end

Então("a sequência deve se manter igual") do
  expect(@contador.sequencia).to eq(@sequencia_atual)
end

Então('deve exibir uma mensagem como "{string}"') do |mensagem|
  expect(@contador.mensagem).to eq(mensagem)
end

Então('deve exibir uma mensagem informando que a sequência foi reiniciada como "{string}"') do |mensagem|
  expect(@contador.mensagem).to eq(mensagem)
end

Então('deve exibir uma mensagem informando que a contribuição diária já foi registrada como "{string}"') do |mensagem|
  expect(@contador.mensagem).to eq(mensagem)
end

Então("deve exibir uma recompensa especial ou destaque para o marco de {int} dias") do |dias|
  msg = @contador.mensagem.downcase
  expect(msg).to include("#{dias} dias")
  expect(msg).to satisfy { |m| m.include?("recompensa") || m.include?("destaque") }
end

Então("deve exibir uma mensagem com recompensa para o marco") do
  msg = @contador.mensagem.downcase
  expect(msg).to satisfy { |m| m.include?("recompensa") || m.include?("destaque") || m.include?("marco") }
end

Então("o usuário deve ter uma sequência de {int} para {string}") do |dias, tipo|
  expect(@contador.sequencia).to eq(dias)
end

Então("o usuário deve ter uma maior sequência de {int} para {string}") do |dias, tipo|
  expect(@maior_sequencia).to eq(dias)
end

Então("a maior sequência do usuário deve permanecer {int} dias") do |dias|
  expect(@maior_sequencia).to eq(dias)
end

Então("deve ver uma seção de sequências") do
  expect(page).to have_selector('.user-streaks-section')
end

Então("deve ver a sequência atual de cada atividade") do
  expect(page).to have_selector('.streak-current-value')
end

Então("deve ver a maior sequência de cada atividade") do
  expect(page).to have_selector('.streak-longest-value')
end

Então("deve ver a data do último registro de cada sequência") do
  expect(page).to have_selector('.streak-last-date')
end