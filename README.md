# [<img src="https://raw.githubusercontent.com/AndyObtiva/glimmer/master/images/glimmer-logo-hi-res.png" height=85 />](https://github.com/AndyObtiva/glimmer) Glimmer DSL for Swing 0.0.1
## JRuby Swing Desktop Development GUI Library
[![Gem Version](https://badge.fury.io/rb/glimmer-dsl-swing.svg)](http://badge.fury.io/rb/glimmer-dsl-swing)
[![Join the chat at https://gitter.im/AndyObtiva/glimmer](https://badges.gitter.im/AndyObtiva/glimmer.svg)](https://gitter.im/AndyObtiva/glimmer?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

[Glimmer](https://github.com/AndyObtiva/glimmer) DSL for [Swing](https://docs.oracle.com/javase/tutorial/uiswing/) enables building desktop applications with [Java Swing](https://docs.oracle.com/javase/tutorial/uiswing/), [Java AWT](https://docs.oracle.com/javase/8/docs/technotes/guides/awt/index.html), [Java Foundation Classes](https://docs.oracle.com/javase/tutorial/uiswing/start/about.html) and [Java 2D](https://docs.oracle.com/javase/tutorial/2d/index.html) via [JRuby](https://www.jruby.org/).

There has been a great divide between two big GUI toolkits in Java in the past:
- [Eclipse SWT](https://www.eclipse.org/swt/)
- [Java Swing/AWT/JFC/2D](https://docs.oracle.com/javase/tutorial/uiswing/)

[Glimmer](https://github.com/AndyObtiva/glimmer) intentionally avoided [Swing](https://docs.oracle.com/javase/tutorial/uiswing/)-like GUI toolkits in the past because they produced non-native looking graphical user interfaces that not only looked out of place in various operating systems, but also degraded usability, user experience, and the professional look of applications significantly, especially given that unlike [SWT](https://www.eclipse.org/swt/), [Swing](https://docs.oracle.com/javase/tutorial/uiswing/) performance is affected by [Java Garbage Collection](https://docs.oracle.com/javase/8/docs/technotes/guides/troubleshoot/performissues003.html) pauses. As such, [Glimmer DSL for SWT](https://github.com/AndyObtiva/glimmer-dsl-swt) was initially born as the premiere [Glimmer](https://github.com/AndyObtiva/glimmer) DSL.

That said, from a balanced software engineering point of view, there are sometimes non-functional requirements that might target [Swing](https://docs.oracle.com/javase/tutorial/uiswing/) as an appropriate GUI toolkit solution. Like in the case of extending legacy [Swing](https://docs.oracle.com/javase/tutorial/uiswing/) applications or developing rare applications that require fully custom looking graphical user interfaces (typically not recommended), such as traffic control planning or diagramming applications. In the latter case, it would not matter whether to use [SWT](https://www.eclipse.org/swt/) or [Swing](https://docs.oracle.com/javase/tutorial/uiswing/) as they both provide support for building non-native components (in addition to native widgets in the case of [SWT](https://www.eclipse.org/swt/)).

[Glimmer DSL for Swing](https://rubygems.org/gems/glimmer-dsl-swing) aims to supercharge productivity and maintainability in developing [Swing](https://docs.oracle.com/javase/tutorial/uiswing/) applications by providing a DSL similar to [Glimmer DSL for SWT](https://github.com/AndyObtiva/glimmer-dsl-swt) having:
- Declarative DSL syntax that visually maps to the GUI component hierarchy
- Convention over configuration via smart defaults and automation of low-level details
- Requiring the least amount of syntax possible to build GUI
- Custom Keyword support
- Bidirectional Data-Binding to declaratively wire and automatically synchronize GUI with Business Models
- Scaffolding for new custom components, apps, and gems
- Native-Executable packaging on Mac, Windows, and Linux.

Hello, World!

![screenshots/glimmer-dsl-swing-mac-hello-world.png](screenshots/glimmer-dsl-swing-mac-hello-world.png)

```ruby
jframe('Hello, World!') {
  jlabel('Hello, World!')
}.show
```

NOTE: Glimmer DSL for Swing is currently in early alpha mode (incomplete proof-of-concept). Please help make better by contributing, adopting for small or low risk projects, and providing feedback. It is still an early alpha, so the more feedback and issues you report the better.

Other [Glimmer](https://rubygems.org/gems/glimmer) DSL gems you might be interested in:
- [glimmer-dsl-swt](https://github.com/AndyObtiva/glimmer-dsl-swt): Glimmer DSL for SWT (JRuby Desktop Development GUI Framework)
- [glimmer-dsl-opal](https://github.com/AndyObtiva/glimmer-dsl-opal): Glimmer DSL for Opal (Pure Ruby Web GUI and Auto-Webifier of Desktop Apps)
- [glimmer-dsl-tk](https://github.com/AndyObtiva/glimmer-dsl-tk): Glimmer DSL for Tk (MRI Ruby Desktop Development GUI Library)
- [glimmer-dsl-gtk](https://github.com/AndyObtiva/glimmer-dsl-gtk): Glimmer DSL for GTK (Ruby-GNOME Desktop Development GUI Library)
- [glimmer-dsl-libui](https://github.com/AndyObtiva/glimmer-dsl-libui): Glimmer DSL for Tk (Prerequisite-Free Ruby Desktop Development GUI Library)
- [glimmer-dsl-xml](https://github.com/AndyObtiva/glimmer-dsl-xml): Glimmer DSL for XML (& HTML)
- [glimmer-dsl-css](https://github.com/AndyObtiva/glimmer-dsl-css): Glimmer DSL for CSS

## Prerequisites

- JDK 8 (find at https://www.oracle.com/java/technologies/downloads/#java8)
- [RVM](http://rvm.io) on Mac & Linux (not available on Windows)
- JRuby 9.2.19.0 (supporting Ruby 2.5.x syntax) (get via [RVM](http://rvm.io) on Mac and Linux by running `rvm install jruby-9.2.19.0`; On Windows, find at [https://www.jruby.org/download](https://www.jruby.org/download))

Note: On the Mac, if you have [Glimmer DSL for SWT](https://github.com/AndyObtiva/glimmer-dsl-swt) installed, and it added `export JRUBY_OPTS="$JRUBY_OPTS -J-XstartOnFirstThread"` to your `.zprofile`, `.zshrc`, `.bash_profile`, or `.bashrc`, make sure to disable it before using Glimmer DSL for Swing. Unfortunately, it is not compatible with it and will hang its apps until disabled.

## Setup

### Option 1: Install

Run this command to install directly:
```
gem install glimmer-dsl-swing
```

### Option 2: Bundler

Add the following to `Gemfile`:
```
gem 'glimmer-dsl-swing', '~> 0.0.1'
```

And, then run:
```
bundle
```

## Usage

Require the library and mixin the `Glimmer` module to utilize the Glimmer GUI DSL for Swing:

```ruby
require 'glimmer-dsl-swing'

include Glimmer

jframe('Hello, World!') {
  jlabel('Hello, World!')
}.show
```

## Glimmer GUI DSL

The Glimmer GUI DSL enables development of desktop graphical user interfaces in a manner similar to HTML, but in one language, Ruby, thus avoiding the multi-language separation dissonance encountered on the web, especially given that Ruby looping/conditional constructs do not need scriptlets to be added around View code. This makes desktop development extremely productive.

1 - Keywords

You may declare any swing/awt component with its keyword, which is the underscored version of the class name. For example, `jframe` is the keyword for `javax.swing.JFrame` (`j_frame` is acceptable too)

Examples:

```ruby
jframe
jbutton
jlabel
```

2 - Arguments

You may pass any arguments that a [swing](https://docs.oracle.com/javase/8/docs/api/javax/swing/package-summary.html)/[awt](https://docs.oracle.com/javase/8/docs/api/java/awt/package-summary.html) component constructor accepts to its Glimmer keyword.

Example `JFrame`, `JLabel`, and `JButton` have a constructor signature that accepts a string representing title or text:

```ruby
jframe('Hello, World!')
jbutton('Push Me')
jlabel('Name')
```

The recommended style is to always wrap arguments with parentheses for component keywords.

3 - Content Block

You may pass a content block to any [swing](https://docs.oracle.com/javase/8/docs/api/javax/swing/package-summary.html)/[awt](https://docs.oracle.com/javase/8/docs/api/java/awt/package-summary.html) component keyword, which contains properties and/or nested components.

Example:

```ruby
jframe('Hello, World!') {
  minimum_size 320, 240

  jlabel('Hello, World!')
}
```

The recommended style for the content block is to always be curly braces to denote as View nesting code different from the logic in looping/conditional constructs that utilize `do;end` instead.

Property arguments never have parentheses.

4 - Listeners

You may declare listeners with their event method name on the [swing](https://docs.oracle.com/javase/8/docs/api/javax/swing/package-summary.html)/[awt](https://docs.oracle.com/javase/8/docs/api/java/awt/package-summary.html) listener class (these are the classes in the signatures of `AddXYZListener` methods on [swing](https://docs.oracle.com/javase/8/docs/api/javax/swing/package-summary.html)/[awt](https://docs.oracle.com/javase/8/docs/api/java/awt/package-summary.html) component classes).

For example, `JButton` has an `AddXYZListener` method called `AddActionListener`, which accepts an `ActionListener` class. That class has one event method: `actionPerformed`. In Glimmer, you simply underscore that and prefix with `on_`:

```ruby
jframe('Hello, Button!') {
  jbutton('Click') {
    on_action_performed do
      puts 'Clicked!'
    end
  }
}
```

The recommended style for listeners is always a `do; end` block.

5 - Component Proxy & Methods

When utilizing the Glimmer GUI DSL, you get back proxy objects that wrap [swing](https://docs.oracle.com/javase/8/docs/api/javax/swing/package-summary.html)/[awt](https://docs.oracle.com/javase/8/docs/api/java/awt/package-summary.html) components. To access the original component wrapped by the proxy object, you may call the `#original` method.

Furthermore, you may invoke any method available on the component on the proxy object, like the `#show` method on `JFrame`.

```ruby
frame1 = jframe('Hello, World!') {
  # ...
}
frame1.show
```

### Shape DSL

[Glimmer DSL for Swing](https://rubygems.org/gems/glimmer-dsl-swing) might be the only Ruby Swing DSL out there that supports an additional Shape DSL.

This enables declarative painting of arbitrary shapes using Java 2D, which is similar to how SVG works on the web.

Simply utilize underscored shape names from the `java.awt.geom` [package classes](https://docs.oracle.com/javase/8/docs/api/java/awt/geom/package-summary.html) minus the `2D` suffix, following the same general rules of the [Glimmer GUI DSL](#glimmer-gui-dsl).

For example, `Arc2D` becomes simply `arc`.

Additionally, you can set `draw_color` or `fill_color` property as an rgb/rgba hash (e.g. `r: 255, g: 0, b: 0`)

Example:

```ruby
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
```

![screenshots/glimmer-dsl-swing-mac-hello-shapes.png](screenshots/glimmer-dsl-swing-mac-hello-shapes.png)

## Girb (Glimmer IRB)

You can run the `girb` command (`bin/girb` if you cloned the project locally):

```
girb
```

This gives you `irb` with the `glimmer-dsl-gtk` gem loaded and the `Glimmer` module mixed into the main object for easy experimentation with GUI.

## Samples

### Hello Samples

#### Hello, World!

Run with gem installed:

```
jruby -r glimmer-dsl-swing -e "require 'samples/hello/hello_world'"
```

Or run from locally cloned project directory:

```
jruby -r ./lib/glimmer-dsl-swing samples/hello/hello_world.rb
```

![screenshots/glimmer-dsl-swing-mac-hello-world.png](screenshots/glimmer-dsl-swing-mac-hello-world.png)

```ruby
require 'glimmer-dsl-swing'

include Glimmer

jframe('Hello, World!') {
  jlabel('Hello, World!')
}.show
```

#### Hello, Button!

Run with gem installed:

```
jruby -r glimmer-dsl-swing -e "require 'samples/hello/hello_button'"
```

Or run from locally cloned project directory:

```
jruby -r ./lib/glimmer-dsl-swing samples/hello/hello_button.rb
```

![screenshots/glimmer-dsl-swing-mac-hello-button.png](screenshots/glimmer-dsl-swing-mac-hello-button.png)

```ruby
require 'glimmer-dsl-swing'

include Glimmer

jframe('Hello, Button!') {
  @button = jbutton('Click To Increment: 0') {
    on_action_performed do
      button_text_match = @button.text.match(/(.*)(\d+)$/)
      count = button_text_match[2].to_i + 1
      @button.text = "#{button_text_match[1]}#{count}"
    end
  }
}.show
```

#### Hello, Shapes!

Run with gem installed:

```
jruby -r glimmer-dsl-swing -e "require 'samples/hello/hello_shapes'"
```

Or run from locally cloned project directory:

```
jruby -r ./lib/glimmer-dsl-swing samples/hello/hello_shapes.rb
```

![screenshots/glimmer-dsl-swing-mac-hello-shapes.png](screenshots/glimmer-dsl-swing-mac-hello-shapes.png)

```ruby
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
```

## Resources

- Oracle Swing Tutorial: https://docs.oracle.com/javase/tutorial/uiswing/
- Oracle Java 2D Tutorial: https://docs.oracle.com/javase/tutorial/2d/index.html
- Oracle Swing JavaDoc: https://docs.oracle.com/javase/8/docs/api/javax/swing/package-summary.html
- Oracle AWT JavaDoc: https://docs.oracle.com/javase/8/docs/api/java/awt/package-summary.html
- Oracle AWT Geom JavaDoc: https://docs.oracle.com/javase/8/docs/api/java/awt/geom/package-summary.html

## Process

[Glimmer Process](https://github.com/AndyObtiva/glimmer/blob/master/PROCESS.md)

## Help

### Issues

If you encounter [issues](https://github.com/AndyObtiva/glimmer-dsl-swing/issues) that are not reported, discover missing features that are not mentioned in [TODO.md](TODO.md), or think up better ways to use [Swing](https://docs.oracle.com/javase/tutorial/uiswing/) than what is possible with [Glimmer DSL for Swing](https://rubygems.org/gems/glimmer-dsl-swing), you may submit an [issue](https://github.com/AndyObtiva/glimmer-dsl-swing/issues/new) or [pull request](https://github.com/AndyObtiva/glimmer-dsl-swing/compare) on [GitHub](https://github.com). In the meantime while waiting for a fix, you may try older gem versions of [Glimmer DSL for Swing](https://rubygems.org/gems/glimmer-dsl-swing) in case you find one that does not have the issue and actually works.

### Chat

If you need live help, try to [![Join the chat at https://gitter.im/AndyObtiva/glimmer](https://badges.gitter.im/AndyObtiva/glimmer.svg)](https://gitter.im/AndyObtiva/glimmer?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

## Planned Features and Feature Suggestions

These features have been planned or suggested. You might see them in a future version of [Glimmer DSL for Swing](https://rubygems.org/gems/glimmer-dsl-swing). You are welcome to contribute more feature suggestions.

[TODO.md](TODO.md)

## Change Log

[CHANGELOG.md](CHANGELOG.md)

## Contributing

-   Check out the latest master to make sure the feature hasn't been
    implemented or the bug hasn't been fixed yet.
-   Check out the issue tracker to make sure someone already hasn't
    requested it and/or contributed it.
-   Fork the project.
-   Start a feature/bugfix branch.
-   Commit and push until you are happy with your contribution.
-   Make sure to add tests for it. This is important so I don't break it
    in a future version unintentionally.
-   Please try not to mess with the Rakefile, version, or history. If
    you want to have your own version, or is otherwise necessary, that
    is fine, but please isolate to its own commit so I can cherry-pick
    around it.

## Contributors

* [Andy Maleh](https://github.com/AndyObtiva) (Founder)

[Click here to view contributor commits.](https://github.com/AndyObtiva/glimmer-dsl-swing/graphs/contributors)

## Copyright

[MIT](LICENSE.txt)

Copyright (c) 2021 Andy Maleh.

--

[<img src="https://raw.githubusercontent.com/AndyObtiva/glimmer/master/images/glimmer-logo-hi-res.png" height=40 />](https://github.com/AndyObtiva/glimmer) Built for [Glimmer](https://github.com/AndyObtiva/glimmer) (DSL Framework).
