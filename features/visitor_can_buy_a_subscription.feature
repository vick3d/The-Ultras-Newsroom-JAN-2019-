@javascript @stripe
Feature: Visitor can buy a subscription

   As a user
   In order to get access to the best articles
   I would like to be able to buy a subscription


   Background:
      Given the following users exist
         | email          | password | role    |
         | jocke@craft.se | password | visitor |
      And I am logged in as "jocke@craft.se"

   Scenario: Visitor buys a subscription
      When I visit the site
      And I click "Subscribe"
      And I wait 2 seconds
      And I fill in the payment form with valid cc credentials
      And I click "Submit payment"
      Then I should see "You have successfully subscribed!"



