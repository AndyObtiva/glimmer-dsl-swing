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

require 'glimmer/dsl/expression'
require 'glimmer/dsl/parent_expression'

module Glimmer
  module DSL
    module Swing
      class ComponentExpression < Expression
        include ParentExpression
  
        def can_interpret?(parent, keyword, *args, &block)
          keyword = "j_#{keyword[1..-1]}" if keyword.match(/j[a-z]/) # TODO move this logic to ComponentProxy
          Glimmer::Swing::ComponentProxy.exist?(keyword)
        end
  
        def interpret(parent, keyword, *args, &block)
          keyword = "j_#{keyword[1..-1]}" if keyword.match(/j[a-z]/) # TODO move this logic to ComponentProxy
          Glimmer::Swing::ComponentProxy.create(parent, keyword, *args, &block)
        end
        
        def add_content(parent, keyword, *args, &block)
          super
          parent.post_add_content
        end
        
#         def around(parent, keyword, args, block, &interpret_and_add_content)
#           if parent.nil? && keyword == 'jframe'
#             Java::JavaxSwing::SwingUtilities.invoke_later(&interpret_and_add_content)
#
#           else
#             super
#           end
#         end
      end
    end
  end
end

require 'glimmer/swing/component_proxy'
