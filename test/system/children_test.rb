require "application_system_test_case"

class ChildrenTest < ApplicationSystemTestCase
  setup do
    @child = children(:baby)
  end

  test "uploading an avatar" do
    visit edit_child_path(@child)
    
    # Make sure the file input is visible
    find("#child_avatar", visible: :all).attach_file(
      Rails.root.join("test/fixtures/files/test_avatar.jpg")
    )
    
    click_button "Update Child"
    
    assert_text "Child was successfully updated"
    assert_selector "img[data-image-modal-target='preview']"
  end

  test "displays modal when clicking avatar" do
    visit edit_child_path(@child)
    
    # Make sure the file input is visible and attach file
    find("#child_avatar", visible: :all).attach_file(
      Rails.root.join("test/fixtures/files/test_avatar.jpg")
    )
    click_button "Update Child"
    
    # Click the avatar to open modal
    find("img[data-image-modal-target='preview']").click
    
    # Verify modal is shown
    assert_selector "[data-image-modal-target='modal']", visible: true
    
    # Click outside modal to close
    find("[data-image-modal-target='overlay']").click
    
    # Verify modal is hidden
    assert_no_selector "[data-image-modal-target='modal']", visible: true
  end
end 