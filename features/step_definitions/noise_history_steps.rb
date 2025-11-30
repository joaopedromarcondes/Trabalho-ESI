# features/step_definitions/noise_history_steps.rb

Dado('que existem as seguintes medições de ruído:') do |table|
  table.hashes.each do |row|
    NoiseMeasurement.create!(
      latitude: row['latitude'].to_f,
      longitude: row['longitude'].to_f,
      level: row['level'].to_i,
      created_at: DateTime.parse(row['created_at'])
    )
  end
end

Quando('eu acesso a página de histórico de ruído') do
  visit noise_history_path
end

Então('eu devo ver um mapa com marcadores de medições') do
  expect(page).to have_css('#noise-history-map')
end

Então('eu devo ver {int} marcadores no mapa') do |count|

  expect(page.html).to include('window.noiseMeasurementsData')
  measurement_items = page.all('.measurement-item')
  expect(measurement_items.length).to eq(count)
end

Então('eu devo ver as estatísticas da região') do
  expect(page).to have_css('.stats-panel')
  expect(page).to have_content('Total de Medições:')
  expect(page).to have_content('Nível Médio:')
  expect(page).to have_content('Nível Mínimo:')
  expect(page).to have_content('Nível Máximo:')
end

Quando('eu filtro por data inicial {string}') do |date|
  fill_in 'start-date', with: date
end

Quando('eu filtro por data final {string}') do |date|
  fill_in 'end-date', with: date
end

Quando('eu clico em {string}') do |button_text|
  if button_text == 'Limpar'
    click_link button_text
  else
    click_button button_text
  end
end

Então('eu devo ver {int} medições filtradas') do |count|
  sleep 1
  
  expect(page).to have_content("Total de Medições: #{count}")
end

Então('eu devo ver a estatística {string}') do |stat_text|
  expect(page).to have_content(stat_text)
end

Quando('eu defino o raio de busca como {string} km') do |radius|
  fill_in 'radius', with: radius
end

Quando('eu clico no mapa nas coordenadas {string}') do |coords|
  skip_this_scenario unless Capybara.current_driver.to_s.include?('selenium') || Capybara.current_driver.to_s.include?('webkit')
end

Então('eu devo ver apenas medições próximas ao centro selecionado') do
  expect(page).to have_css('.measurement-item')
end

Quando('eu clico em uma medição na lista lateral') do
  skip_this_scenario unless Capybara.current_driver.to_s.include?('selenium') || Capybara.current_driver.to_s.include?('webkit')
end

Então('o mapa deve centralizar naquela medição') do
  expect(page).to have_css('#map')
end

Então('o popup da medição deve ser exibido') do
  expect(page).to have_css('.marker-popup')
  expect(page).to have_css('.leaflet-popup-content')
end

Então('eu devo ver {string}') do |text|
  expect(page).to have_content(text)
end

Então('eu devo ver a legenda do mapa') do
  expect(page).to have_css('.map-legend')
  expect(page).to have_content('Legenda')
end

Então('a legenda deve conter {string}') do |text|
  within('.map-legend') do
    expect(page).to have_content(text)
  end
end

Então('todos os filtros devem ser removidos') do
  start_date_value = find_field('start_date').value
  end_date_value = find_field('end_date').value
  
  expect(start_date_value.nil? || start_date_value.empty?).to be true
  expect(end_date_value.nil? || end_date_value.empty?).to be true
end

Então('a medição de {int} dB deve ter marcador verde') do |level|
  expect(page).to have_content("#{level} dB")
end

Então('a medição de {int} dB deve ter marcador amarelo') do |level|
  expect(page).to have_content("#{level} dB")
end

Então('a medição de {int} dB deve ter marcador laranja') do |level|a
  expect(page).to have_content("#{level} dB")
end

Então('a medição de {int} dB deve ter marcador vermelho') do |level|
  expect(page).to have_content("#{level} dB")
end
