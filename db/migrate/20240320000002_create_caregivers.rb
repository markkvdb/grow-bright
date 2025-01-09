class CreateCaregivers < ActiveRecord::Migration[8.0]
  def change
    create_table :caregivers do |t|
      t.string :first_name, null: false
      t.string :last_name
      t.string :email, null: false, index: { unique: true }
      t.integer :relationship, null: false

      t.timestamps
    end
  end
end
