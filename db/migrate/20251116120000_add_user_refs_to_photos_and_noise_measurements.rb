class AddUserRefsToPhotosAndNoiseMeasurements < ActiveRecord::Migration[8.0]
  def change
    add_reference :photos, :user, foreign_key: true, index: true, null: true unless column_exists?(:photos, :user_id)
    add_reference :noise_measurements, :user, foreign_key: true, index: true, null: true unless column_exists?(:noise_measurements, :user_id)
  end
end
