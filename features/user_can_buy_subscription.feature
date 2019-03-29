@javascript @stripe
Feature: User can buy a subscription

    As a user
    In order to get access to premium articles
    I would like to be able to buy a subscription

    Background:
        Given the following users exist
            | email             | password | role       |
            | visitor@craft.se  | password | visitor    | 
            | jocke@craft.se    | password | journalist |

        And the following articles exist
            | title                           | lead                   | content                                          | category      | premium | user           |
            | Voted best mead recipe          | Restaurant wins prize  | Restaurant wins prize for best mead in Sweden    | Lifestyle     | true    | jocke@craft.se |

    Scenario: User can buy a subscription (Happy path)
        When I am logged in as "visitor@craft.se"
        And I visit the site
        And I click "Voted best mead recipe"
        And I should see "To read this premium article, you need to become a subscriber."
        But when I click "Subscribe"
        And wait for 3 seconds
        And I fill in the payment form with valid cc credentials
        And I click "Submit payment"
        And wait for 4 seconds
        Then I should see "You have successfully subscribed!"
        And "visitor@craft.se" should be a "subscriber"
        When I click "Voted best mead recipe"
        Then I should see "Restaurant wins prize for best mead in Sweden"

    Scenario: Visitor can not buy a subscription (Sad path)
        When I visit the site
        And I click "Subscribe"
        And wait for 3 seconds
        And I fill in the payment form with valid cc credentials
        And I click "Submit payment"
        And wait for 3 seconds
        Then I should see "You need to be logged in to buy a subscription"
        
    @stripe_error_cvc
    Scenario: User can not buy a subscription with invalid cc credentials (Sad path)
        When I am logged in as "visitor@craft.se"
        And I visit the site
        And I click "Subscribe"
        And wait for 3 seconds
        And I fill in the payment form with invalid cc credentials
        And I click "Submit payment"
        And wait for 3 seconds
        Then I should see "The card's security code is incorrect"