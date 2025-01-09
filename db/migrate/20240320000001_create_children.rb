class CreateChildren < ActiveRecord::Migration[8.0]
  def change
    create_table :children do |t|
      t.string :first_name, null: false
      t.string :last_name
      t.date :birth_date, null: false
      t.decimal :birth_weight_value, precision: 5, scale: 2  # in kg
      t.string :birth_weight_unit, null: false, default: 'kg'
      t.decimal :birth_length_value, precision: 5, scale: 2  # in cm
      t.string :birth_length_unit, null: false, default: 'cm'

      t.timestamps
    end
  end
end
