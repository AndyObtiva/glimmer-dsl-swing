require 'glimmer-dsl-swing'
require 'glimmer/data_binding/observer'

class HelloButton
  include Glimmer
  
  attr_accessor :count

  def initialize
    self.count = 0
    observer = Glimmer::DataBinding::Observer.proc { @button.text = "Click To Increment: #{count}" }
    observer.observe(self, :count)
  end
  
  def launch
    jframe('Hello, Button!') {
      @button = jbutton('Click To Increment: 0') {
        on_action_performed do
          self.count += 1
        end
      }
    }.show
  end
end

HelloButton.new.launch
