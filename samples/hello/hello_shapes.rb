require 'glimmer-dsl-swing'

include Glimmer

jframe('Hello, Shapes!') {
  minimum_size 400, 400
  
  arc(40, 40, 90, 90, 30, 230, 0) {
    fill_paint 255, 0, 0
    draw_paint 0, 128, 255
    stroke 3
  }
  
  arc(40, 140, 90, 90, 30, 230, 1) {
    fill_paint 255, 0, 0
    draw_paint 0, 128, 255
    stroke 3
  }
  
  arc(40, 240, 90, 90, 30, 230, 2) {
    fill_paint 255, 0, 0
    draw_paint 0, 128, 255
    stroke 3
  }
  
  rectangle(140, 40, 180, 90) {
    fill_paint 255, 255, 0
    draw_paint 255, 0, 0
    stroke 3
  }
  
  round_rectangle(140, 140, 180, 90, 60, 40) {
    fill_paint 255, 255, 0
    draw_paint 255, 0, 0
    stroke 3
  }

  ellipse(140, 240, 180, 90) {
    fill_paint 255, 255, 0
    draw_paint 255, 0, 0
    stroke 3
  }
  
  line(180, 60, 280, 110) {
    draw_paint 255, 0, 0
    stroke 3
  }
  
  quad_curve(170, 60, 180, 90, 220, 100) {
    draw_paint 0, 255, 0
    stroke 3
  }
  
  cubic_curve(190, 60, 240, 40, 220, 80, 260, 70) {
    draw_paint 0, 0, 255
    stroke 3
  }
  
  path {
    move_to 200, 150
    line_to 270, 170
    line_to 250, 220
    line_to 220, 190
    line_to 200, 200
    line_to 180, 170
    
    close_path
    
    fill_paint 0, 255, 0
    draw_paint 0, 0, 255
    stroke 3
  }
  
  path {
    move_to 160, 300
    curve_to 190, 260, 200, 280, 210, 270
    curve_to 240, 280, 250, 300, 260, 290
    curve_to 290, 290, 300, 310, 310, 300
    
    fill_paint 0, 255, 0
    draw_paint 0, 0, 255
    stroke 3
  }
}.show
