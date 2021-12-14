require 'glimmer-dsl-swing'

include Glimmer

jframe('Hello, Shapes!') {
  minimum_size 640, 480
  
  arc(20, 20, 90, 90, 0, 360, 0)
}.show
