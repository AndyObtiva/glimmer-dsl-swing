# Copyright (c) 2021 Andy Maleh
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

$LOAD_PATH.unshift(File.expand_path('.', __dir__))

# External requires
# require 'logging'
require 'puts_debuggerer' if ENV['pd'].to_s.downcase == 'true'
require 'nested_inherited_jruby_include_package'
# require 'super_module'
require 'java'
require 'concurrent-ruby' # ensures glimmer relies on Concurrent data-structure classes (e.g. Concurrent::Array)
require 'glimmer'
require 'os'
require 'array_include_methods'
require 'facets/string/underscore'
require 'facets/string/camelcase'
require 'facets/hash/stringify_keys'

# Internal requires
require 'glimmer/swing'
require 'glimmer/swing/ext/glimmer'
require 'glimmer/swing/ext/glimmer/config'
require 'glimmer/dsl/swing/dsl'
