# Capybara configuration for Rails 8 with Propshaft

Capybara.asset_host = 'http://localhost:3000' if ENV['CI'].blank?

Capybara.register_driver :selenium_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument("--headless")
  options.add_argument("--disable-gpu")
  options.add_argument("--no-sandbox")
  options.add_argument("--disable-dev-shm-usage")
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.register_driver :chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument("--headless")
  options.add_argument("--disable-gpu")
  options.add_argument("--no-sandbox")
  options.add_argument("--disable-dev-shm-usage")
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

# Use :rack_test by default for speed, since it shares database connection
Capybara.default_driver = :rack_test
Capybara.javascript_driver = :chrome

# Longer timeout for asset loading
Capybara.default_max_wait_time = 5
