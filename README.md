# Formatter for Gherkin Files

[![Build Status](https://travis-ci.org/funkwerk/gherkin_format.svg)](https://travis-ci.org/funkwerk/gherkin_format)
[![Docker Build](https://img.shields.io/docker/automated/gherkin/format.svg)](https://hub.docker.com/r/gherkin/format/)
[![Downloads](https://img.shields.io/gem/dt/gherkin_format.svg)](https://rubygems.org/gems/gherkin_format)
[![Latest Tag](https://img.shields.io/github/tag/funkwerk/gherkin_format.svg)](https://rubygems.org/gems/gherkin_format)

This tool formats gherkin files.

## Usage

run `gherkin_format` on a list of files

    gherkin_format FEATURE_FILES

To replace files with their formatted counterpart add the option `--replace`.

To get detailed information in case of errors use `--verbose`.

To format gherkin files using a custom format, it's possible to specify a template using `--template TEMPLATE`.
The template provided is a erb-template.

These templates are predefined:
 - markdown
 - multi_markdown

### Usage with Docker

Assuming there are feature files in the current directory. Then call.

`docker run -ti -v $(pwd):/src -w /src gherkin/format *.feature`

This will mount the current directory within the Gherkin Format Docker Container and then check all feature files.

## Installation

Install it with:

`sudo gem install gherkin_format`

After that `gherkin_format` executable is available.
