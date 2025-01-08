class AddVolumeAndWeightToFeedings < ActiveRecord::Migration[8.0]
  def change
    change_table :feedings do |t|
      t.decimal :volume_value, precision: 10, scale: 2  # Volume value
      t.string :volume_unit, limit: 12                   # Volume unit (e.g., ml, l)
      t.decimal :weight_value, precision: 10, scale: 2  # Weight value
      t.string :weight_unit, limit: 12                   # Weight unit (e.g., g, kg)

      t.remove :amount_value, :amount_unit               # Remove the old amount fields
    end
  end
end
