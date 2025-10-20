
# Envio de arquivo .mp3 (incorreto)
Dado('que eu estou na página de adicionar foto') do
  visit '/photos/new'
end

Quando('eu adicionar um arquivo .mp3') do
  attach_file('photo[foto]', Rails.root.join('spec/fixtures/files/audio_teste.mp3'))
  click_button 'Salvar'
end

Então('o sistema irá recusar o arquivo') do
  expect(page).to have_content('Foto deve ser JPEG ou PNG. Arquivo inválido.')
end

Quando('eu faço upload de um arquivo .png') do
  attach_file('photo[foto]', Rails.root.join('spec/fixtures/files/foto-valida.png'))
end

E('preencho a latitude com {string} e a longitude com {string}, que são valores válidos') do |latitude, longitude|
  fill_in 'photo[latitude]', with: latitude
  fill_in 'photo[longitude]', with: longitude
end

E('envio o formulário') do
  click_button 'Salvar'
end

Então('o sistema irá aceitar o arquivo e exibir uma mensagem de sucesso.') do
  expect(page).to have_content('Foto criada com sucesso.')
end


Quando('eu tento submeter o formulário sem adicionar uma foto') do
  click_button 'Salvar'
end

Então('o sistema deve recusar a submissão') do
  expect(page).to have_current_path('/photos')
end

Então('deve exibir a mensagem de erro {string}') do |string|
  expect(page).to have_content(string)
end

Dado('que eu estou visualizando os detalhes de uma área verde já mapeada') do
  @area_verde = AreaVerde.create(nome: 'Praça das Flores', descricao: 'Área testada', coordenadas: '...')
  visit "/areas_verdes/#{@area_verde.id}"
end

Quando('eu seleciono a opção {string}') do |string|
  find_button(string).click
end

Quando('tiro uma foto de lixo acumulado') do
  attach_file('photo[image]', Rails.root.join('spec/fixtures/files/lixo_acumulado.png'))
end

Quando('envio a imagem') do
  click_button 'Enviar Foto'
end

Então('o sistema deve exibir a mensagem {string}') do |string|
  expect(page).to have_content(string)
end

Então('o pino daquela área no mapa deve mudar para a cor amarela para indicar um alerta.') do
  pin = find(".pin")
  expect(pin[:style]).to include('background-color: yellow')
end

E('deve diminuir o {string} daquela área.') do |string|
  expect(@area_verde.nivel_confianca).to be < 0
end

Dado('que eu estou visualizando uma área mapeada por outro usuário') do
  @area_verde = AreaVerde.create(nome: 'Praça das Flores', descricao: 'Área testada', coordenadas: '...')
  visit "/areas_verdes/#{@area_verde.id}"
end

Quando('eu toco no botão {string}') do |string|
  click_button string
end

Quando('tiro uma foto da área verde') do
  attach_file('photo[image]', Rails.root.join('spec/fixtures/files/lixo_acumulado.png'))
end

Então('o sistema deve aumentar o {string} daquela área') do |string|
  expect(@area_verde.nivel_confianca).to be > 0
end

Então('deve mostrar uma mensagem {string}') do |string|
  expect(page).to have_content(string)
end

Dado('que eu estou na página de fotos') do
  visit '/photos'
end

Quando('eu visualizo um mapa com os pontos de fotos de áreas verdes') do
  expect(page).to have_selector('#map')

  nova_foto = FactoryBot.create(:photo, latitude: -23.55052, longitude: -46.633308) # no meio de São Paulo

  visit current_path # força o reload do mapa
  expect(page).to have_selector('#map')
end


E('escolho um ponto no mapa') do
  using_wait_time 5 do
    expect(page).to have_css('.leaflet-marker-icon', visible: true)

    # Pega todos os markers visíveis
    visible_markers = all('.leaflet-marker-icon', visible: true)

    # Se quiser garantir que realmente há um na viewport (opcional)
    raise "Nenhum marcador visível encontrado!" if visible_markers.empty?
    puts "Marcadores visíveis encontrados: #{visible_markers.size}"

    marker = visible_markers[1]
    page.execute_script("arguments[0].click();", marker)

    # Aguarda o popup aparecer
    expect(page).to have_css('.leaflet-popup', visible: true)

    # Seleciona o link "Editar imagem" dentro do popup e guarda em @link
    @link = find('.leaflet-popup a', text: 'Editar imagem', visible: true)
  end
end



Então('eu abro a opção de editar o ponto') do
  expect(@link).to be_visible
  @link.click
  expect(page).to have_current_path(/\/photos\/\d+\/edit/)
end


Então('altero a latitude para {string} e a longitude para {string}') do |string, string2|
  fill_in 'photo[latitude]', with: string
  fill_in 'photo[longitude]', with: string2
end

Então('salvo as alterações') do
  click_button 'Salvar'
end

Então('o sistema deve mostrar a página da foto alterada') do
  expect(page).to have_current_path(/\/photos\/\d+/)
end

Então('deve exibir a mensagem de sucesso {string}') do |string|
  expect(page).to have_content(string)
end