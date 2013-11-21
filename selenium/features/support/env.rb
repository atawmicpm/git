require 'capybara/cucumber'
require 'selenium/webdriver'
require 'chromedriver/helper'

Capybara.default_driver = :selenium

Capybara.register_driver :selenium do |app|
 Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

# caps = Selenium::WebDriver::Remote::Capabilities.chrome

# Capybara.default_driver = :selenium
# Capybara.register_driver :selenium do|app|
# 	Capybara::Selenium::Driver.new(app,
# 		:desired_capabilities => caps)
# end


# @driver = new RemoteWebDriver("http://localhost:9515", DesiredCapabilities.chrome());
# @driver = new Chromedriver();
# caps = Selenium::WebDriver::Remote::Capabilities.chrome
# @driver = Selenium::WebDriver.for(
#       :remote,
#       :url => "http://192.168.1.30:4444/wd/hub",
#       :desired_capabilities => caps)
# @driver = Selenium::WebDriver.for :chrome