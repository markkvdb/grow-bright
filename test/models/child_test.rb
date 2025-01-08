require "test_helper"

class ChildTest < ActiveSupport::TestCase
  test "should not save child without first name" do
    child = Child.new(birth_date: Date.current)
    assert_not child.save, "Saved the child without a first name"
  end

  test "should not save child without birth date" do
    child = Child.new(first_name: "Test")
    assert_not child.save, "Saved the child without a birth date"
  end

  test "should save child with valid attributes" do
    child = Child.new(
      first_name: "Test",
      birth_date: Date.current,
      birth_weight_value: 3.5,
      birth_weight_unit: "kg",
      birth_length_value: 50,
      birth_length_unit: "cm"
    )
    assert child.save, "Could not save the child with valid attributes"
  end

  test "should calculate age in months correctly" do
    child = Child.new(
      first_name: "Test",
      birth_date: 6.months.ago.to_date
    )
    assert_equal 6, child.age_in_months
  end

  test "should calculate age correctly" do
    child = Child.new(
      first_name: "Test",
      birth_date: 2.years.ago.to_date
    )
    assert_equal 2, child.age
  end

  test "should handle birth measurements correctly" do
    child = Child.new(
      first_name: "Test",
      birth_date: Date.current,
      birth_weight_value: 3.5,
      birth_weight_unit: "kg",
      birth_length_value: 50,
      birth_length_unit: "cm"
    )

    expected_weight = Measured::Weight.new(3.5, "kg")
    expected_length = Measured::Length.new(50, "cm")

    assert_measured_equals expected_weight, child.birth_weight
    assert_measured_equals expected_length, child.birth_length
  end
end 