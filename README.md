Formatter for Gherkin Files
===========================

[![Build Status](https://travis-ci.org/funkwerk/gherkin_format.svg)](https://travis-ci.org/funkwerk/gherkin_format)

This tool formats gherkin files.

Usage
-----

run `gherkin_format` on a list of files

    gherkin_format FEATURE_FILES

To replace files with their formatted counterpart add the option `--replace`.

To get detailed information in case of errors use `--verbose`.

To format gherkin files using a custom format, it's possible to specify a template using `--template TEMPLATE`.
The template provided is a erb-template.

These templates are predefined:
 - markdown
 - multi_markdown
