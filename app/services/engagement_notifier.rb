class EngagementNotifier
  class << self
    attr_accessor :notificacao_perms, :sent_notifications

    def notificacao_perms
      @notificacao_perms ||= {}
    end

    def sent_notifications
      @sent_notifications ||= {}
    end

    def run_daily
      users = User.where.not(confirmed_at: nil)
      users.find_each do |user|
        email = user.email

        perm = notificacao_perms.fetch(email, true)
        next unless perm

        last_sent = sent_notifications[email]
        if last_sent == Date.today
          next
        end

        home = begin
          Rails.application.routes.url_helpers.root_url(host: ENV['APP_HOST'] || 'http://example.com')
        rescue StandardError
          '/'
        end

        mail = ActionMailer::Base.mail(from: 'no-reply@example.com', to: email,
                                       subject: 'Lembrete diário',
                                       body: "Olá, não se esqueça de entrar em nosso site hoje! Acesse: #{home}")
        mail.deliver_now

        sent_notifications[email] = Date.today
      end
    end
  end
end
