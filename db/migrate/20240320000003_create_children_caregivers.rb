class CreateChildrenCaregivers < ActiveRecord::Migration[8.0]
  def change
    create_table :children_caregivers do |t|
      t.references :child, null: false, foreign_key: true
      t.references :caregiver, null: false, foreign_key: true

      t.index [:child_id, :caregiver_id], unique: true
    end
  end
end 