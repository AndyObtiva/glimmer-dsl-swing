require 'glimmer-dsl-swing'

include Glimmer

jframe('Hello, Button!') {
  @button = jbutton('Click To Increment: 0') {
    on_action_performed {
      button_text_match = @button.text.match(/(.*)(\d+)$/)
      count = button_text_match[2].to_i + 1
      @button.text = "#{button_text_match[1]}#{count}"
    }
  }
}.show
