require 'minitest/autorun'
require 'gherkin_format'

# gherkin format test
class GherkinFormatTest < Minitest::Unit::TestCase
  def setup
    @format = GherkinFormat.new
  end

  def test_formats_string
    # setup
    feature = %(Feature: Foo
Scenario:   Bar)
    expected = %(Feature: Foo

  Scenario: Bar
)

    # exercise
    actual = @format.format_string(feature)

    # verify
    assert_equal expected, actual
  end
end
