require "test_helper"

class MeasurementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @measurement = measurements(:one_month)
    @child = @measurement.child
    @caregiver = @child.caregivers.first
    @user = @caregiver.user

    sign_in_as(@user)
  end

  test "should get index" do
    get child_measurements_path(@child)
    assert_response :success
  end

  test "should get new" do
    get new_child_measurement_path(@child)
    assert_response :success
  end

  test "creates measurement" do
    assert_difference("Measurement.count") do
      post child_measurements_path(@child), params: {
        measurement: {
          date: Date.current,
          weight_value: 8.5,
          weight_unit: "kg",
          length_value: 70,
          length_unit: "cm",
          head_circumference_value: 45,
          head_circumference_unit: "cm",
          caregiver_id: @caregiver.id
        }
      }
    end

    measurement = Measurement.last
    assert_equal 8.5, measurement.weight_value
    assert_equal "kg", measurement.weight_unit
  end

  test "validates measurement units" do
    post child_measurements_path(@child), params: {
      measurement: {
        date: Date.current,
        weight_value: 8.5,
        weight_unit: "invalid",
        caregiver_id: @caregiver.id
      }
    }

    assert_response :unprocessable_entity
  end

  test "updates measurement" do
    patch child_measurement_path(@child, @measurement), params: {
      measurement: {
        weight_value: 9.0
      }
    }

    assert_redirected_to child_path(@child)
    @measurement.reload
    assert_equal 9.0, @measurement.weight_value
  end

  test "deletes measurement" do
    assert_difference("Measurement.count", -1) do
      delete child_measurement_path(@child, @measurement)
    end

    assert_redirected_to child_path(@child)
  end
end
