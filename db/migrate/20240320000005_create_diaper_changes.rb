class CreateDiaperChanges < ActiveRecord::Migration[8.0]
  def change
    create_table :diaper_changes do |t|
      t.references :child, null: false, foreign_key: true
      t.references :caregiver, null: false, foreign_key: true
      t.datetime :time, null: false
      t.integer :change_type, null: false  # enum: wet, solid, both
      t.integer :color  # enum
      t.integer :consistency  # enum: loose, normal, firm
      t.text :notes

      t.timestamps

      t.index :time
    end
  end
end
