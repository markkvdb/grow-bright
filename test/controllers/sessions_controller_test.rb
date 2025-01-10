require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end

  test "should get login page" do
    get new_session_path
    assert_response :success
    assert_select "h2", "GrowBright"
  end

  test "should login with valid credentials" do
    @user = User.create!(email_address: "test@example.com", password: "password")

    post session_url, params: { 
      email_address: @user.email_address,
      password: @user.password
    }
    
    assert_redirected_to root_path
  end

  test "should not login with invalid password" do
    post session_url, params: {
      email_address: @user.email_address,
      password: "wrong_password"
    }
    
    assert_equal "Try another email address or password.", flash[:alert]
  end

  test "should not login with invalid email" do
    post session_url, params: {
      email_address: "nonexistent@example.com",
      password: "password"
    }
    
    assert_equal "Try another email address or password.", flash[:alert]
  end

  test "should logout" do
    sign_in_as(@user)
    delete session_url

    assert_redirected_to new_session_path
  end
end 