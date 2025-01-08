class CreateActivities < ActiveRecord::Migration[8.0]
  def change
    create_table :activities do |t|
      t.references :child, null: false, foreign_key: true
      t.references :caregiver, null: false, foreign_key: true
      t.integer :activity_type, null: false  # enum: tummy_time, bath, play, etc.
      t.datetime :start_time, null: false
      t.datetime :end_time
      t.boolean :milestone, default: false
      t.text :notes

      t.timestamps

      t.index :start_time
    end
  end
end 