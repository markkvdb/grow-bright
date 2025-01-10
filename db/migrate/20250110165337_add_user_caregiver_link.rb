class AddUserCaregiverLink < ActiveRecord::Migration[8.0]
  def change
    remove_column :caregivers, :email
    add_reference :users, :caregiver, foreign_key: true, null: false
  end
end
