require "test_helper"

class FeedingTest < ActiveSupport::TestCase
  test "should validate units for bottle feeding" do
    feeding = Feeding.new(
      child: children(:baby),
      caregiver: caregivers(:mom),
      feeding_type: :bottle,
      start_time: Time.current,
      end_time: Time.current + 10.minutes,
      volume_value: 120,
      volume_unit: "ml"
    )
    assert feeding.valid?, "Feeding should be valid with ml unit"

    feeding.volume_unit = "g"
    assert_not feeding.valid?
    assert_includes feeding.errors[:volume], "is not a valid unit"
  end

  test "should validate units for solid feeding" do
    feeding = Feeding.new(
      child: children(:baby),
      caregiver: caregivers(:mom),
      feeding_type: :solid,
      start_time: Time.zone.now,
      end_time: Time.zone.now + 10.minutes,
      weight_value: 50,
      weight_unit: "g"
    )

    assert feeding.valid?, feeding.errors.full_messages.join(", ")

    feeding.weight_unit = "ml"
    assert_not feeding.valid?, "Feeding should not be valid with ml unit"
    assert_includes feeding.errors[:weight], "is not a valid unit"
  end


  test "should not require amount for breast feeding" do
    feeding = Feeding.new(
      child: children(:baby),
      caregiver: caregivers(:mom),
      feeding_type: :breast,
      start_time: Time.current,
      end_time: Time.current + 10.minutes,
      side: :left
    )
    assert feeding.valid?
  end
end
