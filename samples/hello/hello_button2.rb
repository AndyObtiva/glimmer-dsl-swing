require 'glimmer-dsl-swing'

class Counter
  attr_accessor :count

  def initialize
    self.count = 0
  end
end

class HelloButton
  include Glimmer
  
  def initialize
    @counter = Counter.new

    observe(@counter, :count) do |new_count|
      @button.text = "Click To Increment: #{new_count}"
    end
  end
  
  def launch
    jframe('Hello, Button!') {
      @button = jbutton('Click To Increment: 0') {
        on_action_performed do
          @counter.count += 1
        end
      }
    }.show
  end
end

HelloButton.new.launch
