ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

# Load all files from test/support
Dir[Rails.root.join("test", "support", "**", "*.rb")].each { |f| require f }

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  include MeasuredHelpers

  setup do
    # Store files locally.
    ActiveStorage::Current.url_options = { host: "localhost" }
  end

  teardown do
    # Clean up uploaded files after each test
    FileUtils.rm_rf(ActiveStorage::Blob.service.root)
  end
end
