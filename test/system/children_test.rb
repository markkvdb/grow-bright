require "application_system_test_case"

class ChildrenTest < ApplicationSystemTestCase
  setup do
    @child = children(:baby)
    @user = users(:one)
    @caregiver = @child.caregivers.first
    @other_caregiver = caregivers(:dad)
    @user.update!(caregiver: @caregiver)

    sign_in_as(@user)
  end

  test "creating a child" do
    visit children_path
    click_on "Add New Baby"

    fill_in "First name", with: "Test"
    fill_in "Last name", with: "Baby"
    fill_in "Birth date", with: "2023-01-01"
    
    # User's caregiver should be pre-selected and disabled
    assert_selector "select[disabled]" do
      assert_selector "option", text: @caregiver.full_name
    end
    
    # Add another caregiver
    click_on "Add Another Caregiver"
    within(".grid[data-nested-form-target='entries']") do
      # Select the new caregiver
      select @other_caregiver.full_name, from: "child[children_caregivers_attributes][1][caregiver_id]"
      select "Grandparent", from: "child[children_caregivers_attributes][1][relationship]"
    end

    click_on "Add Child"

    assert_text "Child was successfully recorded"
    
    # Verify relationships were created
    child = Child.last
    assert_equal 2, child.children_caregivers.count
    assert_includes child.caregivers, @caregiver
    assert_includes child.caregivers, @other_caregiver
    assert_equal "parent", child.children_caregivers.find_by(caregiver: @caregiver).relationship
    assert_equal "grandparent", child.children_caregivers.find_by(caregiver: @other_caregiver).relationship
  end

  test "updating a child's caregivers" do
    child = children(:baby)
    
    visit edit_child_path(child)

    # Add another caregiver
    click_on "Add Another Caregiver"
    within(".grid[data-nested-form-target='entries']") do
      select @other_caregiver.full_name, from: "child[children_caregivers_attributes][1][caregiver_id]"
      select "Nanny", from: "child[children_caregivers_attributes][1][relationship]"
    end

    click_on "Update Child"

    assert_text "Child was successfully updated"
    
    # Verify relationships
    child.reload
    assert_equal 2, child.children_caregivers.count
    assert_includes child.caregivers, @other_caregiver
    assert_equal "nanny", child.children_caregivers.find_by(caregiver: @other_caregiver).relationship
  end

  test "removing a caregiver from a child" do
    child = children(:baby)
    child.children_caregivers.create!(caregiver: @other_caregiver, relationship: "grandparent")
    
    visit edit_child_path(child)

    # The user's caregiver should not have a remove button
    within(".grid[data-nested-form-target='entries']") do
      within(all(".flex.items-center")[0]) do
        assert_no_selector "button[data-action='click->nested-form#remove']"
      end
      
      # Remove the other caregiver
      within(all(".flex.items-center")[1]) do
        find("button[data-action='click->nested-form#remove']").click
      end
    end

    click_on "Update Child"

    assert_text "Child was successfully updated"
    
    # Verify the relationship was removed
    child.reload
    assert_equal 1, child.children_caregivers.count
    assert_not_includes child.caregivers, @other_caregiver
  end

  test "cannot select the same caregiver twice" do
    visit new_child_path

    fill_in "First name", with: "Test"
    fill_in "Birth date", with: "2023-01-01"

    # Add two caregivers
    click_on "Add Another Caregiver"
    within(".grid[data-nested-form-target='entries']") do
      select @other_caregiver.full_name
    end
    
    # The add button should be hidden since no more caregivers are available
    assert_no_selector "button", text: "Add Another Caregiver"
  end

  test "uploading an avatar" do
    visit edit_child_path(@child)

    # Make sure the file input is visible
    find("#child_avatar", visible: :all).attach_file(
      Rails.root.join("test/fixtures/files/test_avatar.jpg")
    )

    click_on "Update Child"

    assert_text "Child was successfully updated"
    assert_selector "img[src*='test_avatar.jpg']"
  end
end
