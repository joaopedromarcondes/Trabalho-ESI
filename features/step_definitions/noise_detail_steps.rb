@mapa

# Esquema: Visualizar o nível de ruído detalhado
#  Como um morador curioso
#  Eu quero poder tocar em uma área específica do mapa
#  Para que eu possa visualizar o nível de ruído detalhado naquela localidade

# Cenário: Clicar em uma área do mapa e ver o nível de ruído
#  Dado que existem medições de ruído registradas
#  Quando eu clico em uma área do mapa
#  Então eu devo ver o nível de ruído detalhado daquela localidade

Quando('eu clico em uma área do mapa') do
  visit root_path
  # Simula o clique em uma região do mapa
  # Supondo que cada área tenha uma div ou botão com classe .map-area
  find('.map-area', match: :first).click
end

Então('eu devo ver o nível de ruído detalhado daquela localidade') do
    # Exemplo: o app mostra "Nível de ruído: 75 dB"
  within('#noise-detail') do
    expect(page).to have_content('Nível de ruído')
    expect(page).to have_content('dB')
  end
end
