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
require 'glimmer/swing/component_listener_proxy'

module Glimmer
  module Swing
    # Proxy for Swing/AWT component objects
    #
    # Follows the Proxy Design Pattern
    class ComponentProxy
      include Packages

      class << self
        def exist?(keyword)
          !!component_class(keyword)
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
        build
        post_add_content if @block.nil?
      end
      
      # Subclasses may override to perform post add_content work (normally must call super)
      def post_add_content
        @parent_proxy&.post_initialize_child(self)
      end
      
      # Subclasses may override to perform post initialization work on an added child (normally must also call super)
      def post_initialize_child(child)
        if child.is_a?(ComponentProxy)
          add(child)
        elsif child.is_a?(ShapeProxy)
          shape_proxies << child
        end
      end
      
      def shape_proxies
        @shape_proxies ||= []
      end
      
      def respond_to?(method_name, *args, &block)
        respond_to_original?(method_name, *args, &block) ||
          super(method_name, true)
      end
      
      def respond_to_original?(method_name, *args, &block)
        @original.respond_to?(method_name, true) || @original.respond_to?("set_#{method_name}", true)
      end
      
      def method_missing(method_name, *args, &block)
        if respond_to?("#{method_name}=", true) && !args.empty?
          send("#{method_name}=", *args)
        elsif @original.respond_to?("set_#{method_name}", true) && !args.empty?
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
      
      def can_handle_observation_request?(observation_request)
        if observation_request.start_with?('on_')
          event = observation_request.sub(/^on_/, '')
          can_add_listener?(event)
        end
      end
      
      def handle_observation_request(observation_request, &block)
        if observation_request.start_with?('on_')
          event = observation_request.sub(/^on_/, '')
          if can_add_listener?(event)
            event = observation_request.sub(/^on_/, '')
            add_listener(event, &block)
          end
        end
      end
      
      def can_add_listener?(underscored_listener_name)
        @original && !self.class.find_listener(@original.getClass, underscored_listener_name).empty?
      end

      def add_listener(underscored_listener_name, &block)
        component_add_listener_method, listener_class, listener_method = self.class.find_listener(@original.getClass, underscored_listener_name)
        component_listener_proxy = nil
        listener = listener_class.new(listener_method => block)
        @original.send(component_add_listener_method, listener)
        ComponentListenerProxy.new(component: @original, listener: listener, component_add_listener_method: component_add_listener_method, listener_class: listener_class, listener_method: listener_method)
      end

      # Looks through SWT class add***Listener methods till it finds one for which
      # the argument is a listener class that has an event method matching
      # underscored_listener_name
      def self.find_listener(component_class, underscored_listener_name)
        @listeners ||= {}
        listener_key = [component_class.name, underscored_listener_name]
        unless @listeners.has_key?(listener_key)
          listener_method_name = underscored_listener_name.camelcase(:lower)
          component_class.getMethods.each do |component_add_listener_method|
            if component_add_listener_method.getName.match(/add.*Listener/)
              component_add_listener_method.getParameterTypes.each do |listener_type|
                listener_type.getMethods.each do |listener_method|
                  if (listener_method.getName == listener_method_name)
                    @listeners[listener_key] = [component_add_listener_method.getName, listener_class(listener_type), listener_method.getName]
                    return @listeners[listener_key]
                  end
                end
              end
            end
          end
          @listeners[listener_key] = []
        end
        @listeners[listener_key]
      end

      # Returns a Ruby class that implements listener type Java interface with ability to easily
      # install a block that gets called upon calling a listener event method
      def self.listener_class(listener_type)
        @listener_classes ||= {}
        listener_class_key = listener_type.name
        unless @listener_classes.has_key?(listener_class_key)
          @listener_classes[listener_class_key] = Class.new(Object).tap do |listener_class|
            listener_class.send :include, (eval listener_type.name.sub("interface", ""))
            listener_class.define_method('initialize') do |event_method_block_mapping|
              @event_method_block_mapping = event_method_block_mapping
            end
            listener_type.getMethods.each do |event_method|
              listener_class.define_method(event_method.getName) do |*args|
                @event_method_block_mapping[event_method.getName]&.call(*args)
              end
            end
          end
        end
        @listener_classes[listener_class_key]
      end

      private
      
      def build
        @original = ComponentProxy.component_class(keyword).new(*normalize_args(args))
        setup_shape_painting
      end
      
      def setup_shape_painting
        @original.class.alias_method(:paint_without_glimmer, :paint)
        @original.class.define_method(:paint) do |g2|
          paint_without_glimmer(g2)
          shape_proxies.each do |shape_proxy|
            original_color = g2.get_color
            if shape_proxy.fill_color
              g2.color = Color.new(shape_proxy.fill_color[:r], shape_proxy.fill_color[:g], shape_proxy.fill_color[:b], shape_proxy.fill_color[:a] || 255)
              g2.fill(shape_proxy)
            end
            if shape_proxy.draw_color
              g2.color = Color.new(shape_proxy.draw_color[:r], shape_proxy.draw_color[:g], shape_proxy.draw_color[:b], shape_proxy.draw_color[:a] || 255)
              g2.draw(shape_proxy)
            end
            g2.color = original_color
          end
        end
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
require 'glimmer/swing/shape_proxy'
