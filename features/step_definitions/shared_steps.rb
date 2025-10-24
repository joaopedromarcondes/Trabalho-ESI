# features/step_definitions/shared_steps.rb

Dado('que existem medições de ruído registradas') do
  NoiseMeasurement.create!(latitude: -23.561, longitude: -46.656, level: 75)
  NoiseMeasurement.create!(latitude: -23.562, longitude: -46.657, level: 60)
end

Dado('que existem medições de ruído registradas com níveis elevados') do
  FactoryBot.create(:noise_measurement, latitude: -23.561, longitude: -46.656, level: 85)
  FactoryBot.create(:noise_measurement, latitude: -23.562, longitude: -46.657, level: 90)
end

Dado('que existem medições de ruído registradas com níveis baixos') do
  FactoryBot.create(:noise_measurement, latitude: -23.561, longitude: -46.656, level: 45)
  FactoryBot.create(:noise_measurement, latitude: -23.562, longitude: -46.657, level: 50)
end

Dado('que não existem medições de ruído registradas') do
  NoiseMeasurement.delete_all
end

Dado('que o usuário está na página inicial') do
  visit root_path
end

Dado('que o usuário está na página de medições de ruído') do
  visit noise_measurements_path
end

Dado('que o usuário está na página de estatísticas de ruído') do
  visit noise_statistics_path
end
