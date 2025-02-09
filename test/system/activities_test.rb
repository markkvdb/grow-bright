require "application_system_test_case"

class ActivitiesTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
    sign_in_as(@user)

    @child = children(:baby)
    @caregiver = caregivers(:mom)
    @activity = activities(:tummy_time)
  end

  test "creating a regular activity" do
    visit new_child_activity_path(@child)

    select "Tummy Time", from: "Activity type"
    select @caregiver.full_name, from: "Caregiver"
    fill_in "Notes", with: "Regular tummy time session"

    click_on "Add Activity"

    assert_text "Activity was successfully recorded"
  end

  test "creating a milestone activity" do
    visit new_child_activity_path(@child)

    select "Play", from: "Activity type"
    select @caregiver.full_name, from: "Caregiver"
    check "Is this a milestone?"
    fill_in "Notes", with: "First time grabbing toy!"

    click_on "Add Activity"

    assert_text "Activity was successfully recorded"
  end

  test "updating an activity" do
    activity = activities(:tummy_time)
    visit edit_child_activity_path(@child, activity)

    fill_in "Notes", with: "Updated notes"

    click_on "Update Activity"

    assert_text "Activity was successfully updated"
  end

  test "deleting an activity" do
    visit child_path(@child)

    page.accept_alert do
      find(".delete-activity", match: :first).click
    end
    assert_text "Activity was successfully deleted"
  end

  test "creating an activity with images" do
    visit new_child_activity_path(@child)

    select "Tummy Time", from: "Activity type"
    select @caregiver.full_name, from: "Caregiver"

    # Attach test images
    attach_file "activity[image_files][]", [
      Rails.root.join("test/fixtures/files/test_image1.jpg"),
      Rails.root.join("test/fixtures/files/test_image2.jpg")
    ]

    # Wait for direct upload to complete
    assert_selector ".border-green-500", count: 2

    click_on "Add Activity"

    assert_text "Activity was successfully recorded"
    assert_selector "img[src*='test_image1']"
    assert_selector "img[src*='test_image2']"
  end

  test "editing an activity with existing images" do
    # Attach initial images to the activity
    @activity.images.attach(
      io: File.open(Rails.root.join("test/fixtures/files/test_image1.jpg")),
      filename: "test_image1.jpg",
      content_type: "image/jpeg"
    )
    @activity.images.attach(
      io: File.open(Rails.root.join("test/fixtures/files/test_image2.jpg")),
      filename: "test_image2.jpg",
      content_type: "image/jpeg"
    )

    visit edit_child_activity_path(@child, @activity)

    # Verify existing images are shown
    assert_selector "img[src*='test_image1']"
    assert_selector "img[src*='test_image2']"

    # Add a new image
    attach_file "activity[image_files][]",
      Rails.root.join("test/fixtures/files/test_image3.jpg"),
      make_visible: true

    # Wait for direct upload to complete
    assert_selector ".border-green-500"

    click_on "Update Activity"

    assert_text "Activity was successfully updated"
    assert_selector "img[src*='test_image1']"
    assert_selector "img[src*='test_image2']"
    assert_selector "img[src*='test_image3']"
  end


  test "adding new images preserves existing ones" do
    # First create an activity with one image
    visit new_child_activity_path(@child)

    select "Tummy Time", from: "Activity type"
    select @caregiver.full_name, from: "Caregiver"

    attach_file "activity[image_files][]", [ Rails.root.join("test/fixtures/files/test_image1.jpg") ]

    click_on "Add Activity"

    assert_text "Activity was successfully recorded"
    assert_selector "img[src*='test_image1.jpg']"

    # Now edit and add another image
    @activity = @child.activities.last
    visit edit_child_activity_path(@child, @activity)

    attach_file "activity[image_files][]", [ Rails.root.join("test/fixtures/files/test_image2.jpg") ]

    click_on "Update Activity"

    assert_text "Activity was successfully updated"
    # Should show both images
    assert_selector "img[src*='test_image1.jpg']"
    assert_selector "img[src*='test_image2.jpg']"
  end

  test "can selectively remove images while adding new ones" do
    # First create an activity with two images
    visit new_child_activity_path(@child)

    select "Tummy Time", from: "Activity type"
    select @caregiver.full_name, from: "Caregiver"

    attach_file "activity[image_files][]", [
      Rails.root.join("test/fixtures/files/test_image1.jpg"),
      Rails.root.join("test/fixtures/files/test_image2.jpg")
    ]

    click_on "Add Activity"

    assert_text "Activity was successfully recorded"

    # Now edit, remove one image and add a new one
    @activity = @child.activities.last
    visit edit_child_activity_path(@child, @activity)

    # Selct first image in the image-previews div and click the remove button
    img = find("#image-previews", match: :first).find("img", match: :first)
    img.hover
    find_button("[data-action='activity-images#remove']", match: :first).click

    attach_file "activity[image_files][]", [ Rails.root.join("test/fixtures/files/test_image3.jpg") ]

    click_on "Update Activity"

    assert_text "Activity was successfully updated"
    # Should show two images (one original, one new)
    assert_selector "img", count: 2
    assert_selector "img[src*='test_image2']"
    assert_selector "img[src*='test_image3']"
  end
end
