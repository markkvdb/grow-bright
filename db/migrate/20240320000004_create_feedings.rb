class CreateFeedings < ActiveRecord::Migration[8.0]
  def change
    create_table :feedings do |t|
      t.references :child, null: false, foreign_key: true
      t.references :caregiver, null: false, foreign_key: true
      t.integer :feeding_type, null: false
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.decimal :amount_value, precision: 10, scale: 2
      t.string :amount_unit, limit: 12
      t.integer :side  # enum: left, right, both
      t.text :notes

      t.timestamps

      t.index :start_time
    end
  end
end 