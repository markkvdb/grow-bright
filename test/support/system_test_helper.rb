module SystemTestHelper
  def sign_in_as(user, password: "password")
    visit new_session_path
    
    fill_in "Email address", with: user.email_address
    fill_in "Password", with: password
    click_button "Sign in"
    
    assert_current_path root_path
  end
end

class ActionDispatch::SystemTestCase
  include SystemTestHelper
end 