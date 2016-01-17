Feature: Template for Multi Markdown Without Highlight
  As a Business Analyst
  I want to format my feature files as multi markdown
  so that I can import them to the wiki of my choice

  Background:
    Given a file named "render_multi_markdown.rb" with:
      """
      $LOAD_PATH << '../../lib'
      require 'gherkin_format'

      formatter = GherkinFormat.new
      template = '../../lib/multi_markdown_without_highlight.erb'
      formatter.render(template, ['foo.feature'])

      """

  Scenario: Simple Feature
    Given a file named "foo.feature" with:
      """
      Feature: Foo
        Scenario: Bar
          Given a foo
          When I bar
          Then I baz
      """
    When I run `ruby render_multi_markdown.rb`
    Then it should pass with exactly:
      """

      ## Feature Foo (foo.feature)

      ### Scenario: Bar

      Given a foo
      When I bar
      Then I baz

      """

  Scenario: Extract Sentences with background
    Given a file named "foo.feature" with:
      """
      Feature: Foo
        Background:
          Given something

        Scenario: Bar
          Given a foo
          When I bar
          Then I baz
      """
    When I run `ruby render_multi_markdown.rb`
    Then it should pass with exactly:
      """

      ## Feature Foo (foo.feature)

      ### Background

      Given something

      ### Scenario: Bar

      Given a foo
      When I bar
      Then I baz

      """

  Scenario: Extract Sentences from outlines
    Given a file named "foo.feature" with:
      """
      Feature: Foo
        Scenario Outline: Bar
          Given a <foo>
          When I <bar>
          Then I <baz>

          Examples: table
            | foo | bar | bazzzzzz |
            | FOOoooo | BAR | BAZ |
            | oof | rabbbbbbb | zab |
      """
    When I run `ruby render_multi_markdown.rb`
    Then it should pass with exactly:
      """

      ## Feature Foo (foo.feature)

      ### Scenario Outline: Bar

      Given a <foo>
      When I <bar>
      Then I <baz>

      #### Examples: table

      | foo     | bar       | bazzzzzz |
      | ------- | --------- | -------- |
      | FOOoooo | BAR       | BAZ      |
      | oof     | rabbbbbbb | zab      |



      """

  Scenario: Extract Sentences considers description
    Given a file named "foo.feature" with:
      """
      Feature: Foo
        As a user,
        I want something
        so that I have that

        Scenario: Bar
          Given a foo
          When I bar
          Then I baz
      """
    When I run `ruby render_multi_markdown.rb`
    Then it should pass with exactly:
      """

      ## Feature Foo (foo.feature)

      As a user,
      I want something
      so that I have that

      ### Scenario: Bar

      Given a foo
      When I bar
      Then I baz

      """

  Scenario: Extract Sentences considers scenario description
    Given a file named "foo.feature" with:
      """
      Feature: Foo
        As a user,
        I want something
        so that I have that

        Scenario: Bar
        This is a sentence description

          Given a foo
          When I bar
          Then I baz
      """
    When I run `ruby render_multi_markdown.rb`
    Then it should pass with exactly:
      """

      ## Feature Foo (foo.feature)

      As a user,
      I want something
      so that I have that

      ### Scenario: Bar

      This is a sentence description

      Given a foo
      When I bar
      Then I baz

      """
