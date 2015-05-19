require 'gherkin/formatter/pretty_formatter'
require 'gherkin/parser/parser'
require 'stringio'

# format gherkin files
class GherkinFormat
  def format_string(input, file = 'generated.feature')
    io = StringIO.new
    formatter = Gherkin::Formatter::PrettyFormatter.new(io, true, false)
    parser = Gherkin::Parser::Parser.new(formatter, true)
    parser.parse(input, file, 0)
    io.string.split("\n").map(&:rstrip).join("\n") + "\n"
  end

  def format(file, options = {})
    input = File.read file
    output = format_string input, file
    return if input == output

    if options.key? :replace
      File.write("#{file}_orig", input)
      File.write("#{file}", output)
    end

    puts "File #{file} is not formatted well."
    fail "File #{file} is not formatted well."
  end
end
