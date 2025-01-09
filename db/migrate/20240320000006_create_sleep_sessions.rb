class CreateSleepSessions < ActiveRecord::Migration[8.0]
  def change
    create_table :sleep_sessions do |t|
      t.references :child, null: false, foreign_key: true
      t.references :caregiver, null: false, foreign_key: true
      t.datetime :start_time, null: false
      t.datetime :end_time
      t.integer :location  # enum: crib, bed, stroller, etc.
      t.text :notes

      t.timestamps

      t.index :start_time
    end
  end
end
