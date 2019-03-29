Feature: Editor can publish articles

    As an editor,
    In order to make sure that the articles have good standards
    I would like to republish updated articles

    Background:
        Given the following users exist
            | email              | password | role       |
            | journalist@mail.se | password | journalist |
            | editor@mail.se     | password | editor     |

        And the following articles exist
            | title                                 | lead                   | content                                          | category      | user               | approved |
            | Voted best mead recipe                | Restaurant wins prize  | Restaurant wins prize for best mead in Sweden    | Lifestyle     | journalist@mail.se | false    |
            | Ancient viking grave discovered       | Kids came across sword | Kids come across sword protruding from the earth | Breaking News | journalist@mail.se | true     |
            | Drinking wine improves general health | Drink wine today!      | Studies show that wine is good for your heart    | Health        | journalist@mail.se | true     |

        And I am logged in as "editor@mail.se"

    Scenario: Editor can publish articles
        Given I visit the editor page
        Then I should see "Voted best mead recipe"
        And I click "Voted best mead recipe"
        And I should see "Publish"
        And I click "Publish"
        And I should see "Article was successfully published."
        When I visit the site
        Then I should see "Voted best mead recipe"

    Scenario: Editor needs to republish updated articles
        Given I am logged in as "journalist@mail.se"
        And I visit the "Ancient viking grave discovered" page
        And I click "Edit"
        And I fill in "Title" with "Ancient viking grave discovered yesterday"
        And I click "Update article"
        Then I should see "Article was successfully updated."
        When I visit the site
        Then I should not see "Ancient viking grave discovered yesterday"
