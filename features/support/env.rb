require 'cucumber/rails'
require 'coveralls'
Coveralls.wear_merged!('rails') 

 World(FactoryBot::Syntax::Methods)

 ActionController::Base.allow_rescue = false

 begin
  DatabaseCleaner.strategy = :transaction
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end

Chromedriver.set_version '2.42'

 chrome_options = %w[headless disable-popup-blocking disable-infobars]

 chrome_options << 'auto-open-devtools-for-tabs'

 Capybara.register_driver :chrome do |app|
	options = Selenium::WebDriver::Chrome::Options.new(
		args: chrome_options
		)
		Capybara::Selenium::Driver.new(
			app,
			browser: :chrome,
			options: options
			)
end

Cucumber::Rails::Database.javascript_strategy = :truncation

Capybara.server = :puma
Capybara.javascript_driver = :chrome 