puts "== Seed de NoiseMeasurements =="

puts "Limpando tabela antiga..."
NoiseMeasurement.delete_all

NUM_POINTS = 500

puts "Gerando #{NUM_POINTS} medições de ruído..."

clusters = [
  [-23.5615, -46.6558], # Paulista
  [-23.5568, -46.6396], # Consolação
  [-23.5505, -46.6333], # Centro
  [-23.5671, -46.6480]  # Jardins
]

NUM_POINTS.times do
  base = clusters.sample

  NoiseMeasurement.create!(
    latitude:  base[0] + rand(-0.005..0.005),
    longitude: base[1] + rand(-0.005..0.005),
    level: rand(40..120),
    user_id: nil,
    created_at: Time.current - rand(1..500).minutes
  )
end

puts "Seed finalizado!"
