class MoveRelationshipToChildrenCaregivers < ActiveRecord::Migration[8.0]
  def change
    # Remove from caregivers
    remove_column :caregivers, :relationship, :string

    # Add to children_caregivers
    add_column :children_caregivers, :relationship, :string
  end
end
