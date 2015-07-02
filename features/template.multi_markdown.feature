Feature: Multi Markdown Template
  As a Business Analyst
  I want to format my feature files as multi markdown with highligthing
  so that I can import them to the wiki of my choice

  Background: Prepare Testee
    Given a file named "render_multi_markdown.rb" with:
      """
      $LOAD_PATH << '../../lib'
      require 'gherkin_format'

      formatter = GherkinFormat.new
      formatter.render('../../lib/multi_markdown.erb', ['foo.feature'])

      """

  Scenario: Simple Feature
    Given a file named "foo.feature" with:
      """
      Feature: Foo
        Scenario: Bar
          Given a foo
          When I «bar»
          Then I baz
      """
    When I run `ruby render_multi_markdown.rb`
    Then it should pass with exactly:
      """

      <h2 id="Foo">Foo</h2>

      Source\: foo.feature

      <h3 id="Bar">Scenario: Bar</h3>

      __Given__ a foo
      __When__ I _«bar»_
      __Then__ I baz
      <hr />


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

      <h2 id="Foo">Foo</h2>

      Source\: foo.feature

      <h3 id="">Background</h3>

      __Given__ something

      <h3 id="Bar">Scenario: Bar</h3>

      __Given__ a foo
      __When__ I bar
      __Then__ I baz
      <hr />


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

      <h2 id="Foo">Foo</h2>

      Source\: foo.feature

      <h3 id="Bar">Scenario Outline: Bar</h3>

      __Given__ a _\<foo\>_
      __When__ I _\<bar\>_
      __Then__ I _\<baz\>_



      | foo     | bar       | bazzzzzz |
      | ------- | --------- | -------- |
      | FOOoooo | BAR       | BAZ      |
      | oof     | rabbbbbbb | zab      |
      [_**Examples: table**_]

      <hr />


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

      <h2 id="Foo">Foo</h2>

      Source\: foo.feature

      > As a user,
      > I want something
      > so that I have that

      <h3 id="Bar">Scenario: Bar</h3>

      __Given__ a foo
      __When__ I bar
      __Then__ I baz
      <hr />


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

      <h2 id="Foo">Foo</h2>

      Source\: foo.feature

      > As a user,
      > I want something
      > so that I have that

      <h3 id="Bar">Scenario: Bar</h3>

      > This is a sentence description

      __Given__ a foo
      __When__ I bar
      __Then__ I baz
      <hr />


      """
