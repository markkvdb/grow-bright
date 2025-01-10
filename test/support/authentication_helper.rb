module AuthenticationHelper
  def sign_in_as(user)
    post session_url, params: { 
      email_address: user.email_address,
      password: "password"  # Matches the password in fixtures
    }
    @current_user = user
  end

  def current_user
    @current_user
  end

  def sign_out
    delete session_url
  end

  def assert_requires_authentication
    assert_redirected_to session_url
    assert_equal "You need to sign in first", flash[:alert]
  end
end

class ActionDispatch::IntegrationTest
  include AuthenticationHelper
end

# For controller tests if needed
class ActionController::TestCase
  include AuthenticationHelper
end 