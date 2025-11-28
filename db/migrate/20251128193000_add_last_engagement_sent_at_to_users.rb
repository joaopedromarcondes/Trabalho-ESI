class AddLastEngagementSentAtToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :last_engagement_sent_at, :datetime
  end
end
