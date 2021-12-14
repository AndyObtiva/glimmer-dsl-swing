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

require 'glimmer/swing/packages'

module Glimmer
  module Swing
    # Proxy for Swing/AWT component objects
    #
    # Follows the Proxy Design Pattern
    class ComponentProxy
      include Packages

      class << self
        def exist?(keyword)
          !!component_proxy_class(keyword)
        end
        
        def create(parent, keyword, *args, &block)
          component_proxy_class(keyword).new(parent, keyword, *args, &block)
        end
        
        def component_proxy_class(keyword)
          begin
            class_name = component_proxy_class_symbol(keyword)
            Glimmer::Swing::ComponentProxy.const_get(class_name)
          rescue => e
            Glimmer::Config.logger.debug e.full_message
            Glimmer::Swing::ComponentProxy
          end
        end
        
        def component_proxy_class_symbol(keyword)
          "#{keyword.camelcase(:upper)}Proxy".to_sym
        end
        
        def component_class_symbol(keyword)
          keyword.camelcase(:upper).to_sym
        end
        
        def keyword(component_proxy_class)
          component_proxy_class.to_s.underscore.sub(/_proxy$/, '')
        end
        
        def component_class_manual_entries
          # add mappings for any classes (minus the namespace) that conflict with standard Ruby classes
          {
            # example:
            # 'date_time' => Java::OrgEclipseSwtWidgets::DateTime
          }
        end
          
        def component_class(keyword)
          unless flyweight_component_class.keys.include?(keyword)
            begin
              component_class_name = component_class_symbol(keyword).to_s
              component_class = eval(component_class_name)
              unless component_class.ancestors.include?(Java::JavaAwt::Component)
                component_class = component_class_manual_entries[keyword]
                if component_class.nil?
                  Glimmer::Config.logger.debug {"Class #{component_class} matching #{keyword} is not a subclass of java.awt.Component"}
                  return nil
                end
              end
              flyweight_component_class[keyword] = component_class
            rescue SyntaxError, NameError => e
              Glimmer::Config.logger.debug {e.full_message}
              nil
            rescue => e
              Glimmer::Config.logger.debug {e.full_message}
              nil
            end
          end
          flyweight_component_class[keyword]
        end
        
        # Flyweight Design Pattern memoization cache. Can be cleared if memory is needed.
        def flyweight_component_class
          @flyweight_component_class ||= {}
        end
      end
      
      attr_reader :parent_proxy, :original, :args, :keyword, :block
      
      def initialize(parent, keyword, *args, &block)
        @parent_proxy = parent
        @keyword = keyword
        @args = args
        @block = block
        build_widget
        post_add_content if @block.nil?
      end
      
      # Subclasses may override to perform post add_content work (normally must call super)
      def post_add_content
        @parent_proxy&.post_initialize_child(self)
      end
      
      # Subclasses may override to perform post initialization work on an added child (normally must also call super)
      def post_initialize_child(child)
        add(child)
      end
      
      def respond_to?(method_name, *args, &block)
        respond_to_original?(method_name, *args, &block) ||
          super(method_name, true)
      end
      
      def respond_to_original?(method_name, *args, &block)
        @original.respond_to?(method_name, true) || @original.respond_to?("set_#{method_name}", true)
      end
      
      def method_missing(method_name, *args, &block)
        if @original.respond_to?("set_#{method_name}", true) && !args.empty?
          send_to_original("set_#{method_name}", *args, &block)
        elsif @original.respond_to?(method_name, true)
          send_to_original(method_name, *args, &block)
        else
          super
        end
      end
      
      def send_to_original(method_name, *args, &block)
        @original.send(method_name, *normalize_args(args), &block)
      end
      
      def content(&block)
        Glimmer::DSL::Engine.add_content(self, Glimmer::DSL::Swing::ComponentExpression.new, @keyword, &block)
      end
            
      private
      
      def build_widget
        @original = ComponentProxy.component_class(keyword).new(*normalize_args(args))
      end
      
      def normalize_args(args)
        args.map do |arg|
          arg.is_a?(ComponentProxy) ? arg.original : arg
        end
      end
    end
  end
end

Dir[File.expand_path("./#{File.basename(__FILE__, '.rb')}/*.rb", __dir__)].each {|f| require f}
