require 'glimmer-dsl-swing'

class HelloButton
  include Glimmer
  include Glimmer::Swing::Packages
  
  def launch
    pd self.is_a?(Glimmer::Swing::Packages)
    jframe('Hello, Button!') {
      @button = jbutton('Click To Increment: 0') {
        on_action_performed do
          button_text_match = @button.text.match(/([^0-9]+)(\d+)$/)
          count = button_text_match[2].to_i + 1
          @button.text = "#{button_text_match[1]}#{count}"
        end
      }
    }.show
  end
end

HelloButton.new.launch
