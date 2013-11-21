Given /^I am on (.+)$/ do |url|
	visit "https://gvp-us.genesyscloud.com/?login"
end

When /^I fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
	fill_in(field, :with => value)
end

When /^I press "([^"]*)"$/ do |button|
  click_button(button)
end

Then /^I should see "([^"]*)"$/ do |text|
	assert page.has_content?(text)
end

When /^I refresh the page$/ do
	visit page.driver.browser.current_url
end

When /^I click navigation "([^"]*)"$/ do |link|
	wait = Selenium::WebDriver::Wait.new(:timeout => 10)
	wait.until { page.find("button[data-name=\"#{link}\"]").click }
end

When /^I click sub navigation "([^"]*)"$/ do |link|
	page.find("li[title=\"#{link}\"]").click
end


