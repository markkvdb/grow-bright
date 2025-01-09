class CreateMeasurements < ActiveRecord::Migration[8.0]
  def change
    create_table :measurements do |t|
      t.references :child, null: false, foreign_key: true
      t.references :caregiver, null: false, foreign_key: true
      t.date :date, null: false

      # Weight measurement
      t.decimal :weight_value, precision: 10, scale: 3  # in kg
      t.string :weight_unit

      # Length measurement
      t.decimal :length_value, precision: 10, scale: 2  # in cm
      t.string :length_unit

      # Head circumference measurement
      t.decimal :head_circumference_value, precision: 10, scale: 2  # in cm
      t.string :head_circumference_unit

      t.text :notes

      t.timestamps
    end
  end
end
