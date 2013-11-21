Feature: Genesys GVP GAX administration login works

Background:
	Given I am on https://gvp-us.genesyscloud.com/?login

Scenario: Login to Administrator Portal
	When I fill in "Username" with "monitor"
	When I fill in "Password" with "monitor"
	And I press "Log In"
	Then I should see "Welcome to Administrator Extension"
	Then I refresh the page
	Then I click navigation "accounts"
	Then I click sub navigation "Roles"
