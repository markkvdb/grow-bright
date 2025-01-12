require "application_system_test_case"

class MeasurementsTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
    sign_in_as(@user)

    @child = children(:baby)
    @caregiver = caregivers(:mom)
  end

  test "creating a measurement" do
    visit new_child_measurement_path(@child)

    fill_in "Weight", with: "8.5"
    fill_in "Length", with: "70"
    fill_in "Head Circumference", with: "45"

    select @caregiver.full_name, from: "Caregiver"

    click_on "Add Measurement"

    assert_text "Measurement was successfully recorded"
  end

  test "updating a measurement" do
    measurement = measurements(:one_month)
    visit edit_child_measurement_path(@child, measurement)

    fill_in "Weight", with: "9.0"

    click_on "Update Measurement"

    assert_text "Measurement was successfully updated"
  end
end
