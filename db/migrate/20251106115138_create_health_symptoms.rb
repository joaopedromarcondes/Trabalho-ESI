class CreateHealthSymptoms < ActiveRecord::Migration[8.0]
  def change
    create_table :health_symptoms do |t|
      t.string :sintoma
      t.integer :intensidade

      t.timestamps
    end
  end
end
