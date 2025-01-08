require "application_system_test_case"

class MeasurementsTest < ApplicationSystemTestCase
  setup do
    @child = children(:baby)
    @caregiver = caregivers(:mom)
  end

  test "creating a measurement" do
    visit new_child_measurement_path(@child)
    
    fill_in "Weight", with: "8.5"
    select "kg", from: "measurement[weight_unit]"
    
    fill_in "Length", with: "70"
    select "cm", from: "measurement[length_unit]"
    
    fill_in "Head Circumference", with: "45"
    select "cm", from: "measurement[head_circumference_unit]"
    
    select @caregiver.full_name, from: "Caregiver"
    
    click_on "Create Measurement"
    
    assert_text "Measurement was successfully recorded"
  end

  test "updating a measurement" do
    measurement = measurements(:one_month)
    visit edit_child_measurement_path(@child, measurement)
    
    fill_in "Weight", with: "9.0"
    
    click_on "Update Measurement"
    
    assert_text "Measurement was successfully updated"
  end

  test "deleting a measurement" do
    visit child_path(@child)
    
    within("#measurement_#{measurements(:one_month).id}") do
      accept_confirm do
        click_on "Delete"
      end
    end
    
    assert_text "Measurement was successfully deleted"
  end
end 