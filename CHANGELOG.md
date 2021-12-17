# Change Log

## 0.0.5

- Support `path`, which can primarily contain `move_to`, `line_to`, `curve_to`, `close_path` calls, and secondarily other shapes like `line` or `rectangle`.
- Support invoking component/shape operations in their content (e.g. nesting `move_to` inside `path`)

## 0.0.4

- Support setting `stroke` attribute in shapes
- Rename `draw_color` and `fill_color` to `draw_paint` and `fill_paint` to be consistent with `java.awt.Graphics2D` terminology (while keeping older syntax as an alias/alternative)
- Enable antialiasing by default on Java 2D graphics
- Update Hello, Shapes! to take advantage of `stroke`

## 0.0.3

- Support `observe` keyword for observing model attributes to update the View
- Support adding `include Glimmer` inside a class
- Hello, Button! sample version 2 (decoupled view using `observe` keyword)

## 0.0.2

- General Java 2D shape support by nesting under any component
- Support setting `jframe` `minimum_size width, height` without building `Dimension` object manually
- Hello, Shapes! sample
- Improve Hello, Button! sample

## 0.0.1

- Initial version of Glimmer DSL for Swing
- General component support
- General component property support
- General component listener support
- Hello, World! sample
- Hello, Button! sample
