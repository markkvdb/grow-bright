require "test_helper"

class ActivitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @child = children(:baby)
    @caregiver = caregivers(:mom)
  end

  test "creates activity" do
    assert_difference("Activity.count") do
      post child_activities_path(@child), params: {
        activity: {
          activity_type: "tummy_time",
          start_time: Time.current,
          end_time: Time.current + 15.minutes,
          milestone: false,
          caregiver_id: @caregiver.id,
          notes: "Test activity"
        }
      }
    end

    activity = Activity.last
    assert_equal "tummy_time", activity.activity_type
    assert_equal false, activity.milestone
  end

  test "creates milestone activity" do
    assert_difference("Activity.count") do
      post child_activities_path(@child), params: {
        activity: {
          activity_type: "play",
          start_time: Time.current,
          end_time: Time.current + 30.minutes,
          milestone: true,
          caregiver_id: @caregiver.id,
          notes: "First time grabbing toy!"
        }
      }
    end

    activity = Activity.last
    assert_equal true, activity.milestone
    assert_equal "First time grabbing toy!", activity.notes
  end

  test "updates activity" do
    activity = activities(:tummy_time)
    patch child_activity_path(@child, activity), params: {
      activity: {
        notes: "Updated notes"
      }
    }

    assert_redirected_to child_path(@child)
    activity.reload
    assert_equal "Updated notes", activity.notes
  end

  test "deletes activity" do
    activity = activities(:tummy_time)
    assert_difference("Activity.count", -1) do
      delete child_activity_path(@child, activity)
    end

    assert_redirected_to child_path(@child)
  end
end 