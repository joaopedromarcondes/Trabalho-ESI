class AddAvatarsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :owned_avatars, :text
    add_column :users, :pending_avatar, :string
    add_column :users, :current_avatar, :string

    reversible do |dir|
      dir.up do
        execute "UPDATE users SET owned_avatars = '[]' WHERE owned_avatars IS NULL"
      end
    end
  end
end
