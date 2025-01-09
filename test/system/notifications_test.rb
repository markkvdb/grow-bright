require "application_system_test_case"

class NotificationsTest < ApplicationSystemTestCase
  test "shows success notification with progress bar" do
    visit new_child_path

    fill_in "First name", with: "Test Child"
    fill_in "Birth date", with: "2023-01-01"
    click_button "Create Child"

    # Verify success notification appears
    assert_selector "[data-notification-target='notification']"
    assert_text "Child was successfully recorded"

    # Get initial progress bar width
    progress_bar = find("[data-notification-target='progress']")
    initial_width = progress_bar["style"].match(/width: (\d+)%/)[1].to_i
    assert_in_delta 100, initial_width, 10, progress_bar["style"]

    # Wait a moment and check that the progress bar is closed
    sleep 6.0 # Wait for the progress bar to close
    assert_no_selector "[data-notification-target='progress']"
  end

  test "can manually dismiss notification" do
    visit new_child_path

    fill_in "First name", with: "Test Child"
    fill_in "Birth date", with: "2023-01-01"

    click_on "Create Child"

    assert_selector ".border-green-500"

    find("[data-action='notification#close']").click
    assert_no_selector ".border-green-500"
  end

  test "shows error notification when form has errors" do
    visit new_child_path

    # Submit form without required fields
    click_button "Create Child"

    # Verify error notification appears
    assert_text "prohibited this child from being saved"

    # Check that the errors are displayed
    assert_text "First name can't be blank"
    assert_text "Birth date can't be blank"
  end
end
