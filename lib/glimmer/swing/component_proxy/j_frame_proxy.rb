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

require 'glimmer/swing/component_proxy'

module Glimmer
  module Swing
    class ComponentProxy
      # Proxy for Swing JFrame objects
      #
      # Follows the Proxy Design Pattern
      class JFrameProxy < ComponentProxy
        DEFAULT_WIDTH = 190
        DEFAULT_HEIGHT = 150
        
        def set_minimum_size(*args)
          if args.size == 1 && args.first.is_a?(Java::JavaAwt::Dimension)
            super
          else
            super(Java::JavaAwt::Dimension.new(*args))
          end
        end
        alias minimum_size= set_minimum_size
        
        def post_add_content
          unless @initial_content_added
            @initial_content_added = true
            the_width = minimum_size.width == 0 ? DEFAULT_WIDTH : width
            the_height = minimum_size.height == 0 ? DEFAULT_HEIGHT : height
            set_minimum_size(Java::JavaAwt::Dimension.new(the_width, the_height))
            set_default_close_operation(Java::JavaxSwing::JFrame::EXIT_ON_CLOSE)
          end
        end
        
        def show
          unless @shown_at_least_once
            @shown_at_least_once = true
            Java::JavaxSwing::SwingUtilities.invoke_later do
              pack
              set_visible(true)
            end
          else
            set_visible(true)
          end
        end
      end
    end
  end
end
