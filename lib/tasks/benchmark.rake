namespace :heatmap do
  desc "Roda benchmark dos geradores de heatmap"
  task benchmark: :environment do
    puts "Executando benchmark de heatmap..."
    results = HeatmapBenchmark.run_all

    results.each do |mode, data|
      puts "\n--- #{mode.upcase} ---"
      puts "Tempo: #{data[:time_ms]} ms"
      puts "Tamanho da saída: #{data[:output_size]}"
    end
  end
end
