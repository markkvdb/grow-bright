require "application_system_test_case"

class DiaperChangesTest < ApplicationSystemTestCase
  setup do
    @child = children(:baby)
    @user = users(:one)
    @caregiver = @child.caregivers.first
    sign_in_as(@user)
  end

  test "visiting the diaper changes index" do
    visit child_diaper_changes_path(@child)

    assert_selector "h1", text: "Diaper Changes for #{@child.first_name}"
    assert_text "Add Diaper Change"

    @child.diaper_changes.each do |diaper_change|
      assert_text diaper_change.time.strftime("%B %d, %Y %I:%M %p")
      assert_text diaper_change.change_type.titleize
      assert_text diaper_change.notes.presence || "None"
    end
  end

  test "navigating to new diaper change from index" do
    visit child_diaper_changes_path(@child)
    click_on "Add Diaper Change"
    
    assert_current_path new_child_diaper_change_path(@child)
  end

  test "creating a wet diaper change" do
    visit new_child_diaper_change_path(@child)

    select "Wet", from: "Change type"
    select @caregiver.full_name, from: "Caregiver"

    # Verify solid fields are hidden
    assert_selector "[data-diaper-change-target='solidFields']", visible: false

    click_on "Add Diaper Change"

    assert_text "Diaper change was successfully recorded"
  end

  test "creating a solid diaper change" do
    visit new_child_diaper_change_path(@child)

    select "Solid", from: "Change type"
    select @caregiver.full_name, from: "Caregiver"

    # Verify solid fields are visible
    assert_selector "[data-diaper-change-target='solidFields']", visible: true

    select "Brown", from: "Color"
    select "Normal", from: "Consistency"

    click_on "Add Diaper Change"

    assert_text "Diaper change was successfully recorded"
  end

  test "creating a both type diaper change" do
    visit new_child_diaper_change_path(@child)

    select "Both", from: "Change type"
    select @caregiver.full_name, from: "Caregiver"

    # Verify solid fields are visible
    assert_selector "[data-diaper-change-target='solidFields']", visible: true

    select "Yellow", from: "Color"
    select "Loose", from: "Consistency"
    fill_in "Notes", with: "Test notes"

    click_on "Add Diaper Change"

    assert_text "Diaper change was successfully recorded"
  end
end
