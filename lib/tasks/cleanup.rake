namespace :cleanup do
  desc "Remove todos os NoiseMeasurements"
  task noise: :environment do
    NoiseMeasurement.delete_all
    puts "NoiseMeasurements removidos!"
  end
end
