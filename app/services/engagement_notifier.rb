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

        if notificacao_perms.key?(email)
          perm = notificacao_perms[email]
        elsif user.respond_to?(:daily_notifications)
          perm = user.daily_notifications
        else
          perm = true
        end
        next unless perm

        if user.respond_to?(:last_engagement_sent_at) && user.last_engagement_sent_at&.to_date == Date.today
          next
        end
        
        if user.respond_to?(:last_engagement_sent_at)
          EngagementReminderJob.perform_later(user.id)
        else
          EngagementMailer.daily_reminder(user).deliver_later
          sent_notifications[email] = Date.today
        end
      end
    end

    def run_daily_inline
      users = User.where.not(confirmed_at: nil)
      users.find_each do |user|
        email = user.email

        if notificacao_perms.key?(email)
          perm = notificacao_perms[email]
        elsif user.respond_to?(:daily_notifications)
          perm = user.daily_notifications
        else
          perm = true
        end
        next unless perm

        if user.respond_to?(:last_engagement_sent_at) && user.last_engagement_sent_at&.to_date == Date.today
          next
        end

        EngagementReminderJob.perform_now(user.id)
      end
    end
  end
end
