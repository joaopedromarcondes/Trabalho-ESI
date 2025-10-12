class CreateNoiseMeasurements < ActiveRecord::Migration[8.0]
  def change
    create_table :noise_measurements do |t|
      t.float :latitude
      t.float :longitude
      t.integer :level

      t.timestamps
    end
  end
end
