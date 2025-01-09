require "test_helper"

class ActivitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @child = children(:baby)
    @caregiver = caregivers(:mom)
    @activity = activities(:tummy_time)
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

  test "should create activity with image" do
    # First attach the file to get a signed id
    blob = ActiveStorage::Blob.create_and_upload!(
      io: File.open(Rails.root.join("test/fixtures/files/test_image1.jpg")),
      filename: "test_image1.jpg",
      content_type: "image/jpeg"
    )

    assert_difference("Activity.count") do
      post child_activities_path(@child), params: {
        activity: {
          activity_type: "tummy_time",
          start_time: Time.current,
          end_time: Time.current + 15.minutes,
          caregiver_id: @caregiver.id,
          images: blob.signed_id
        }
      }
    end

    activity = Activity.last
    assert_equal 1, activity.images.count
    assert_redirected_to child_path(@child)
  end

  test "should update activity with new image" do
    # Attach initial image
    @activity.images.attach(
      io: File.open(Rails.root.join("test/fixtures/files/test_image1.jpg")),
      filename: "test_image1.jpg",
      content_type: "image/jpeg"
    )
    initial_image_id = @activity.images.first.signed_id

    patch child_activity_path(@child, @activity), params: {
      activity: {
        images: initial_image_id
      }
    }

    @activity.reload
    assert_equal 1, @activity.images.count
    assert_redirected_to child_path(@child)
  end

  test "should update activity removing images" do
    # Attach initial image
    @activity.images.attach(
      io: File.open(Rails.root.join("test/fixtures/files/test_image1.jpg")),
      filename: "test_image1.jpg",
      content_type: "image/jpeg"
    )

    # Remove all images
    patch child_activity_path(@child, @activity), params: {
      activity: {
        images: ""
      }
    }

    @activity.reload
    assert_equal 0, @activity.images.count
    assert_redirected_to child_path(@child)
  end

  test "should handle invalid image uploads" do
    # Create an invalid blob
    blob = ActiveStorage::Blob.create_and_upload!(
      io: File.open(Rails.root.join("test/fixtures/files/invalid.txt")),
      filename: "invalid.txt",
      content_type: "text/plain"
    )

    assert_no_difference("Activity.count") do
      post child_activities_path(@child), params: {
        activity: {
          activity_type: "tummy_time",
          start_time: Time.current,
          end_time: Time.current + 15.minutes,
          caregiver_id: @caregiver.id,
          images: blob.signed_id
        }
      }
    end

    assert_response :unprocessable_entity
  end

  test "should handle empty image list" do
    patch child_activity_path(@child, @activity), params: {
      activity: {
        images: ""
      }
    }

    @activity.reload
    assert_equal 0, @activity.images.count
    assert_redirected_to child_path(@child)
  end
end
