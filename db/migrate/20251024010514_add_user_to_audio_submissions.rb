class AddUserToAudioSubmissions < ActiveRecord::Migration[8.0]
  def change
    add_reference :audio_submissions, :user, null: false, foreign_key: true
  end
end
