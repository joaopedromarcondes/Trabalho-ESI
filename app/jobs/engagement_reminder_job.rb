class EngagementReminderJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find_by(id: user_id)
    return unless user

    EngagementMailer.daily_reminder(user).deliver_now

    if user.respond_to?(:last_engagement_sent_at)
      user.update_column(:last_engagement_sent_at, Time.current)
    end
  end
end
