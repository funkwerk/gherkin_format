Feature: Clean Gherkin File

  Scenario: clean scenario
    Given a formatted file
    When format it
    Then it does not change.
