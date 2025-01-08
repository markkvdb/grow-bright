require "test_helper"

class FeedingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @child = children(:baby)
    @caregiver = caregivers(:mom)
  end

  test "creates bottle feeding with volume params" do
    assert_difference("Feeding.count") do
      post child_feedings_path(@child), params: {
        feeding: {
          feeding_type: "bottle",
          start_time: Time.current,
          end_time: Time.current + 10.minutes,
          volume_value: 120,
          volume_unit: "ml",
          caregiver_id: @caregiver.id,
          notes: "Test feeding"
        }
      }
    end

    feeding = Feeding.last
    assert_equal "bottle", feeding.feeding_type
    assert_equal 120, feeding.volume_value
    assert_equal "ml", feeding.volume_unit
    assert_nil feeding.weight_value
    assert_nil feeding.side
  end

  test "creates solid feeding with weight params" do
    assert_difference("Feeding.count") do
      post child_feedings_path(@child), params: {
        feeding: {
          feeding_type: "solid",
          start_time: Time.current,
          end_time: Time.current + 10.minutes,
          weight_value: 50,
          weight_unit: "g",
          caregiver_id: @caregiver.id,
          notes: "Test feeding"
        }
      }
    end

    feeding = Feeding.last
    assert_equal "solid", feeding.feeding_type
    assert_equal 50, feeding.weight_value
    assert_equal "g", feeding.weight_unit
    assert_nil feeding.volume_value
    assert_nil feeding.side
  end

  test "creates breast feeding with side param" do
    assert_difference("Feeding.count") do
      post child_feedings_path(@child), params: {
        feeding: {
          feeding_type: "breast",
          start_time: Time.current,
          end_time: Time.current + 10.minutes,
          side: "left",
          caregiver_id: @caregiver.id,
          notes: "Test feeding"
        }
      }
    end

    feeding = Feeding.last
    assert_equal "breast", feeding.feeding_type
    assert_equal "left", feeding.side
    assert_nil feeding.volume_value
    assert_nil feeding.weight_value
  end

  test "rejects invalid params for feeding type" do
    post child_feedings_path(@child), params: {
      feeding: {
        feeding_type: "bottle",
        start_time: Time.current,
        end_time: Time.current + 10.minutes,
        # Try to inject weight params into a bottle feeding
        weight_value: 50,
        weight_unit: "g",
        caregiver_id: @caregiver.id
      }
    }

    feeding = Feeding.last
    assert_nil feeding&.weight_value
    assert_nil feeding&.weight_unit
  end
end 