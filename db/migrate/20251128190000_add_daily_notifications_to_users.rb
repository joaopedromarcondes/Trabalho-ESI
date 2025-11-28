class AddDailyNotificationsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :daily_notifications, :boolean, null: false, default: true
  end
end
