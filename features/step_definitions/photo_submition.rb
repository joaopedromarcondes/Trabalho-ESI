
# Envio de arquivo .mp3 (incorreto)
Dado('que eu estou na página de adicionar foto') do
  #visit '/photos/new'
  pending
end

Quando('eu adicionar um arquivo .mp3') do
  #attach_file('photo[audio]', Rails.root.join('spec/fixtures/files/audio_teste.mp3'))
  #click_button 'Salvar'
  pending
end

Então('o sistema irá recusar o arquivo') do
  #expect(page).to have_content('Formato de arquivo inválido')
  pending
end

E('irá exibir uma mensagem de erro.') do
  pending # Write code here that turns the phrase above into concrete actions
end

Quando('eu faço upload de um arquivo .png') do
  pending # Write code here that turns the phrase above into concrete actions
end

Então('o sistema irá aceitar o arquivo e exibir uma mensagem de sucesso.') do
  pending # Write code here that turns the phrase above into concrete actions
end


Dado('que eu estou na página de adicionar uma nova área') do
  pending # Write code here that turns the phrase above into concrete actions
end

Quando('eu tento submeter o formulário sem adicionar uma foto') do
  pending # Write code here that turns the phrase above into concrete actions
end

Então('o sistema deve recusar a submissão') do
  pending # Write code here that turns the phrase above into concrete actions
end

Então('deve exibir a mensagem de erro {string}') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Dado('que eu estou visualizando os detalhes de uma área verde já mapeada') do
  pending # Write code here that turns the phrase above into concrete actions
end

Quando('eu seleciono a opção {string}') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Quando('tiro uma foto de lixo acumulado') do
  pending # Write code here that turns the phrase above into concrete actions
end

Quando('envio a imagem') do
  pending # Write code here that turns the phrase above into concrete actions
end

Então('o sistema deve exibir a mensagem {string}') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Então('o pino daquela área no mapa deve mudar para a cor amarela para indicar um alerta.') do
  pending # Write code here that turns the phrase above into concrete actions
end

Dado('que eu estou visualizando uma área mapeada por outro usuário') do
  pending # Write code here that turns the phrase above into concrete actions
end

Quando('eu toco no botão {string}') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Quando('tiro uma foto da área verde') do
  pending # Write code here that turns the phrase above into concrete actions
end

Então('o sistema deve aumentar o {string} daquela área') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Então('deve mostrar uma mensagem {string}') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end