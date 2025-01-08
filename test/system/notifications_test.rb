require "application_system_test_case"

class NotificationsTest < ApplicationSystemTestCase
  test "shows success notification with progress bar" do
    visit new_child_path
    
    fill_in "First name", with: "Test Child"
    fill_in "Birth date", with: "2023-01-01"
    
    click_on "Create Child"
    
    assert_selector ".border-green-500", text: "Child was successfully created"
    assert_selector "[data-notification-target='progress']"
    
    # Check progress bar width after 2.5 seconds (should be around 50%)
    sleep 2.5
    progress = find("[data-notification-target='progress']")
    width = progress['style'].match(/width: (\d+)%/)[1].to_i
    assert_in_delta 50, width, 10 # Allow 10% margin of error
    
    # Wait for auto-dismiss
    sleep 3
    assert_no_selector ".border-green-500"
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
    
    click_on "Create Child"
    
    assert_selector ".border-red-500"
  end
end 