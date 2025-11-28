namespace :engagement_notifier do
  desc 'Enviar notificações diárias (síncrono) - para uso com Heroku Scheduler'
  task run_daily: :environment do
    puts "Iniciando envio de notificações diárias (inline) - #{Time.current}"
    EngagementNotifier.run_daily_inline
    puts "Envio finalizado - #{Time.current}"
  end
end
