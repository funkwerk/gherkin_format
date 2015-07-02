Feature: Markdown Template
  As a Business Analyst
  I want to format my feature files as markdown
  so that I can import them to the wiki of my choice

  Background: Prepare Testee
    Given a file named "render_markdown.rb" with:
      """
      $LOAD_PATH << '../../lib'
      require 'gherkin_format'

      formatter = GherkinFormat.new
      formatter.render('../../lib/markdown.erb', ['foo.feature'])

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
    When I run `ruby render_markdown.rb`
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
    When I run `ruby render_markdown.rb`
    Then it should pass with exactly:
      """

      ## Feature Foo (foo.feature)


      ### Background: 

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
            | foo | bar | baz |
            | FOO | BAR | BAZ |
            | oof | rab | zab |
      """
    When I run `ruby render_markdown.rb`
    Then it should pass with exactly:
      """

      ## Feature Foo (foo.feature)


      ### Scenario Outline: Bar

      Given a <foo>
      When I <bar>
      Then I <baz>

      #### Examples: table

      | foo | bar | baz |
      | FOO | BAR | BAZ |
      | oof | rab | zab |


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
    When I run `ruby render_markdown.rb`
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
    When I run `ruby render_markdown.rb`
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
