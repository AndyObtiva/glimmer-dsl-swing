require 'glimmer-dsl-swing'

include Glimmer

jframe('Hello, Shapes!') {
  minimum_size 640, 480
  
  arc(20, 20, 90, 90, 0, 360, 0) {
    fill_color r: 255, g: 0, b: 0
    draw_color r: 0, g: 0, b: 0
  }
}.show
