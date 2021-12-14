# Copyright (c) 2007-2021 Andy Maleh
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

module Glimmer
  module Swing
    # Proxy for component listeners
    #
    # Follows the Proxy Design Pattern
    class ComponentListenerProxy
      attr_reader :component, :listener, :component_add_listener_method, :listener_class, :listener_method

      def initialize(component: nil, listener:, component_add_listener_method: nil, listener_class: nil, listener_method: nil)
        @component = component
        @listener = listener
        @component_add_listener_method = component_add_listener_method
        @listener_class = listener_class
        @listener_method = listener_method
      end
      
      def component_remove_listener_method
        @component_add_listener_method.sub('add', 'remove')
      end
      
      def deregister
        @component.send(component_remove_listener_method, @listener)
      end
      alias unregister deregister # TODO consider dropping unregister (and in Observer too)
    end
  end
end
