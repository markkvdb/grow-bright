require "application_system_test_case"

class SessionsTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
  end

  test "visiting the login page" do
    visit new_session_path
    
    assert_selector "h2", text: "GrowBright"
    assert_selector "p", text: "Supporting your baby's journey"
  end

  test "signing in with valid credentials" do
    visit new_session_path
    
    fill_in "Email address", with: @user.email_address
    fill_in "Password", with: "password"
    click_button "Sign in"

    assert_current_path root_path
  end

  test "signing in with invalid credentials" do
    visit new_session_path
    
    fill_in "Email address", with: @user.email_address
    fill_in "Password", with: "wrong_password"
    click_button "Sign in"

    assert_text "Try another email address or password."
    assert_current_path session_path
  end

  test "signing out" do
    sign_in_as(@user)
    
    click_on "Sign out"
    
    assert_current_path new_session_path
  end
end 