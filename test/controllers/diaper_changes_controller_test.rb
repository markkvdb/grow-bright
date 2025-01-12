require "test_helper"

class DiaperChangesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @child = children(:baby)
    @caregiver = @child.caregivers.first
    @user = users(:one)
    @user.update!(caregiver: @caregiver)

    sign_in_as(@user)
  end

  test "should get index" do
    get child_diaper_changes_url(@child)
    assert_response :success
  end

  test "should create diaper change" do
    assert_difference('DiaperChange.count') do
      post child_diaper_changes_url(@child), params: { diaper_change: { time: Time.current, caregiver_id: @caregiver.id, change_type: "wet", notes: "Changed at home" } }
    end

    assert_redirected_to child_path(@child)
  end

  test "creates wet diaper change" do
    assert_difference("DiaperChange.count") do
      post child_diaper_changes_path(@child), params: {
        diaper_change: {
          change_type: "wet",
          time: Time.current,
          caregiver_id: @caregiver.id
        }
      }
    end

    diaper_change = DiaperChange.last
    assert_equal "wet", diaper_change.change_type
    assert_nil diaper_change.color
    assert_nil diaper_change.consistency
  end

  test "creates solid diaper change with color and consistency" do
    assert_difference("DiaperChange.count") do
      post child_diaper_changes_path(@child), params: {
        diaper_change: {
          change_type: "solid",
          time: Time.current,
          color: "brown",
          consistency: "normal",
          caregiver_id: @caregiver.id
        }
      }
    end

    diaper_change = DiaperChange.last
    assert_equal "solid", diaper_change.change_type
    assert_equal "brown", diaper_change.color
    assert_equal "normal", diaper_change.consistency
  end

  test "rejects invalid params for change type" do
    post child_diaper_changes_path(@child), params: {
      diaper_change: {
        change_type: "wet",
        time: Time.current,
        # Try to inject color/consistency for wet type
        color: "brown",
        consistency: "normal",
        caregiver_id: @caregiver.id
      }
    }

    diaper_change = DiaperChange.last
    assert_nil diaper_change&.color
    assert_nil diaper_change&.consistency
  end
end

