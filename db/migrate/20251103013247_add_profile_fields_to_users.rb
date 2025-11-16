class AddProfileFieldsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :bio, :text unless column_exists?(:users, :bio)
    add_column :users, :location, :string unless column_exists?(:users, :location)
    add_column :users, :website, :string unless column_exists?(:users, :website)
    unless column_exists?(:users, :styled_profile)
      add_column :users, :styled_profile, :boolean, default: false, null: false
    end
  end
end
