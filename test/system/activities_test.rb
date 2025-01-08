require "application_system_test_case"

class ActivitiesTest < ApplicationSystemTestCase
  setup do
    @child = children(:baby)
    @caregiver = caregivers(:mom)
  end

  test "creating a regular activity" do
    visit new_child_activity_path(@child)
    
    select "Tummy Time", from: "Activity type"
    select @caregiver.full_name, from: "Caregiver"
    fill_in "Notes", with: "Regular tummy time session"
    
    click_on "Create Activity"
    
    assert_text "Activity was successfully recorded"
  end

  test "creating a milestone activity" do
    visit new_child_activity_path(@child)
    
    select "Play", from: "Activity type"
    select @caregiver.full_name, from: "Caregiver"
    check "Is this a milestone?"
    fill_in "Notes", with: "First time grabbing toy!"
    
    click_on "Create Activity"
    
    assert_text "Activity was successfully recorded"
  end

  test "updating an activity" do
    activity = activities(:tummy_time)
    visit edit_child_activity_path(@child, activity)
    
    fill_in "Notes", with: "Updated notes"
    
    click_on "Update Activity"
    
    assert_text "Activity was successfully updated"
  end

  test "deleting an activity" do
    visit child_path(@child)
    
    accept_confirm do
      click_on "Delete", match: :first
    end
    
    assert_text "Activity was successfully deleted"
  end
end 