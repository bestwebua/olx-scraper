require 'capybara'

RSpec.configure do |config|

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  Capybara.register_driver :selenium do |app|  
    Capybara::Selenium::Driver.new(app, browser: :firefox)
  end

  Capybara.javascript_driver = :firefox

  Capybara.configure do |config|  
    config.default_max_wait_time = 10
    config.default_driver = :selenium
  end

end