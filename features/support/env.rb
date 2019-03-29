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

 Cucumber::Rails::Database.javascript_strategy = :truncation

 Chromedriver.set_version '2.40'

Capybara.register_driver :selenium do |app|
  options = Selenium::WebDriver::Chrome::Options.new(
      args: %w( disable-popup-blocking disable-infobars)
  )

  Capybara::Selenium::Driver.new(
      app,
      browser: :chrome,
      options: options
  )
end

Capybara.javascript_driver = :selenium

Before '@stripe' do
	StripeMock.start
end

Before '@stripe_error_cvc' do
  StripeMock.prepare_card_error(:incorrect_cvc)
end

After '@stripe' do
	StripeMock.stop
end 