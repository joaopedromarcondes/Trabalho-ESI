class AddOwnedUpgradesToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :owned_upgrades, :text
  end
end
