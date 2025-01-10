require "application_system_test_case"

class FeedingsTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
    sign_in_as(@user)

    @child = children(:baby)
    @caregiver = caregivers(:mom)
  end

  test "dynamically shows volume fields for bottle feeding" do
    visit new_child_feeding_path(@child)

    select "Bottle", from: "Feeding type"

    assert_selector "[data-feeding-target='volumeFields']", visible: true
    assert_selector "[data-feeding-target='weightFields']", visible: false
    assert_selector "[data-feeding-target='sideField']", visible: false

    fill_in "Amount", with: "120"
    # Verify ml unit is displayed
    assert_text "ml"

    click_on "Create Feeding"

    assert_text "Feeding was successfully recorded"
  end

  test "dynamically shows weight fields for solid feeding" do
    visit new_child_feeding_path(@child)

    select "Solid", from: "Feeding type"

    assert_selector "[data-feeding-target='volumeFields']", visible: false
    assert_selector "[data-feeding-target='weightFields']", visible: true
    assert_selector "[data-feeding-target='sideField']", visible: false

    fill_in "Amount", with: "50"
    # Verify g unit is displayed
    assert_text "g"

    click_on "Create Feeding"

    assert_text "Feeding was successfully recorded"
  end

  test "dynamically shows side field for breast feeding" do
    visit new_child_feeding_path(@child)

    select "Breast", from: "Feeding type"

    assert_selector "[data-feeding-target='volumeFields']", visible: false
    assert_selector "[data-feeding-target='weightFields']", visible: false
    assert_selector "[data-feeding-target='sideField']", visible: true

    select "Left", from: "Side"

    click_on "Create Feeding"

    assert_text "Feeding was successfully recorded"
  end
end
