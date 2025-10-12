# features/step_definitions/shared_steps.rb

Dado('que existem medições de ruído registradas') do
  NoiseMeasurement.create!(latitude: -23.561, longitude: -46.656, level: 75)
  NoiseMeasurement.create!(latitude: -23.562, longitude: -46.657, level: 60)
end
