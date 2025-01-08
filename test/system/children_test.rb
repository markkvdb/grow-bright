test "uploading an avatar" do
  visit new_child_path
  
  fill_in "First name", with: "Test Child"
  fill_in "Birth date", with: "2023-01-01"
  
  attach_file "Avatar", Rails.root.join("test/fixtures/files/test_image1.jpg"), make_visible: true
  
  click_on "Create Child"
  
  assert_text "Child was successfully created"
  assert page.has_css?("img[src*='test_image1.jpg']")
end

test "shows default silhouette when no avatar" do
  visit children_path
  
  assert page.has_css?("img[src*='baby-silhouette']")
end 