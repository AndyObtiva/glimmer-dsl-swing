require 'glimmer-dsl-swing'

include Glimmer

jframe('Hello, Shapes!') {
  minimum_size 400, 400
  
  arc(40, 40, 90, 90, 30, 230, 0) {
    fill_color r: 255, g: 0, b: 0
    draw_color r: 0, g: 255, b: 255
  }
  
  arc(40, 140, 90, 90, 30, 230, 1) {
    fill_color r: 255, g: 0, b: 0
    draw_color r: 0, g: 255, b: 255
  }
  
  arc(40, 240, 90, 90, 30, 230, 2) {
    fill_color r: 255, g: 0, b: 0
    draw_color r: 0, g: 255, b: 255
  }
  
  ellipse(140, 40, 180, 90) {
    fill_color r: 0, g: 255, b: 255
    draw_color r: 255, g: 0, b: 0
  }
  
  rectangle(140, 140, 180, 90) {
    fill_color r: 0, g: 255, b: 255
    draw_color r: 255, g: 0, b: 0
  }
  
  round_rectangle(140, 240, 180, 90, 60, 40) {
    fill_color r: 0, g: 255, b: 255
    draw_color r: 255, g: 0, b: 0
  }

  line(180, 60, 280, 110) {
    draw_color r: 0, g: 0, b: 0
  }
  
  quad_curve(170, 60, 180, 90, 220, 100) {
    draw_color r: 0, g: 0, b: 0
  }
  
  cubic_curve(190, 60, 240, 40, 220, 80, 260, 70) {
    draw_color r: 0, g: 0, b: 0
  }
}.show
