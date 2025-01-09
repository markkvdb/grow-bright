require "application_system_test_case"

class DiaperChangesTest < ApplicationSystemTestCase
  setup do
    @child = children(:baby)
    @caregiver = caregivers(:mom)
  end

  test "creating a wet diaper change" do
    visit new_child_diaper_change_path(@child)

    select "Wet", from: "Change type"
    select @caregiver.full_name, from: "Caregiver"

    # Verify solid fields are hidden
    assert_selector "[data-diaper-change-target='solidFields']", visible: false

    click_on "Create Diaper change"

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

    click_on "Create Diaper change"

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

    click_on "Create Diaper change"

    assert_text "Diaper change was successfully recorded"
  end
end
