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

    # check that avatar is set
    assert @child.avatar.attached?, "Avatar is not attached"
  end
end
