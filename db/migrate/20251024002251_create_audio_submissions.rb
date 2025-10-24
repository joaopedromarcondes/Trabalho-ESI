class CreateAudioSubmissions < ActiveRecord::Migration[8.0]
  def change
    create_table :audio_submissions do |t|
      t.float :latitude
      t.float :longitude
      t.integer :duration_seconds

      t.timestamps
    end
  end
end
