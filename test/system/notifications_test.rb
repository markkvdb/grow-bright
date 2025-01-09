require "application_system_test_case"

class NotificationsTest < ApplicationSystemTestCase
  test "shows success notification with progress bar" do
    visit new_child_path
    
    fill_in "First name", with: "Test Child"
    fill_in "Birth date", with: "2023-01-01"
    click_button "Create Child"
    
    # Verify success notification appears
    assert_selector "[data-notification-target='notification']"
    assert_text "Child was successfully created"
    
    # Get initial progress bar width
    progress_bar = find("[data-notification-target='progress']")
    initial_width = progress_bar['style'].match(/width: (\d+)%/)[1].to_i
    assert_equal 100, initial_width
    
    # Wait a moment and check progress
    sleep 2.5 # Wait half the animation time (5000ms)
    current_width = find("[data-notification-target='progress']")['style'].match(/width: (\d+)%/)[1].to_i
    
    # Progress should be roughly halfway (allowing for some timing variance)
    assert_in_delta 50, current_width, 10
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
    assert_selector "[data-notification-target='notification']"
    assert_text "prohibited this child from being saved"
    
    # Verify error styling
    notification = find("[data-notification-target='notification']")
    assert_includes notification[:class], "border-red-500"
    
    # Verify progress bar has error styling
    progress_bar = find("[data-notification-target='progress']")
    assert_includes progress_bar[:class], "bg-red-500"
  end
end 