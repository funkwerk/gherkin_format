FROM ruby
MAINTAINER think@hotmail.de

RUN gem install gherkin_format --no-format-exec
CMD gherkin_format
