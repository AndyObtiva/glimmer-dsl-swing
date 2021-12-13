# [<img src="https://raw.githubusercontent.com/AndyObtiva/glimmer/master/images/glimmer-logo-hi-res.png" height=85 />](https://github.com/AndyObtiva/glimmer) Glimmer DSL for Swing 0.0.1
## JRuby Swing Desktop Development GUI Library
[![Gem Version](https://badge.fury.io/rb/glimmer-dsl-swing.svg)](http://badge.fury.io/rb/glimmer-dsl-swing)
[![Join the chat at https://gitter.im/AndyObtiva/glimmer](https://badges.gitter.im/AndyObtiva/glimmer.svg)](https://gitter.im/AndyObtiva/glimmer?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

[Glimmer](https://github.com/AndyObtiva/glimmer) DSL for [Swing](https://docs.oracle.com/javase/tutorial/uiswing/) enables building desktop applications with [Java Swing](https://docs.oracle.com/javase/tutorial/uiswing/) and [Java 2D](https://docs.oracle.com/javase/tutorial/2d/index.html) via [JRuby](https://www.jruby.org/).

There has been a great divide between two big GUI toolkits in Java in the past:
- [Eclipse SWT](https://www.eclipse.org/swt/)
- [Java Swing/AWT/2D](https://docs.oracle.com/javase/tutorial/uiswing/)

[Glimmer](https://github.com/AndyObtiva/glimmer) intentionally avoided [Swing](https://docs.oracle.com/javase/tutorial/uiswing/)-like GUI toolkits in the past because they produced non-native looking graphical user interfaces that not only looked out of place in various operating systems, but also degraded usability, user experience, and the professional look of applications significantly, especially given that unlike [SWT](https://www.eclipse.org/swt/), [Swing](https://docs.oracle.com/javase/tutorial/uiswing/) performance is affected by [Java Garbage Collection](https://docs.oracle.com/javase/8/docs/technotes/guides/troubleshoot/performissues003.html) pauses. As such, [Glimmer DSL for SWT](https://github.com/AndyObtiva/glimmer-dsl-swt) was initially born as the premiere [Glimmer](https://github.com/AndyObtiva/glimmer) DSL.

That said, from a balanced software engineering point of view, there are sometimes non-functional requirements that might target [Swing](https://docs.oracle.com/javase/tutorial/uiswing/) as an appropriate GUI toolkit solution. Like in the case of extending legacy [Swing](https://docs.oracle.com/javase/tutorial/uiswing/) applications or developing rare applications that require fully custom looking graphical user interfaces (typically not recommended), such as traffic control planning or diagramming applications. In the latter case, it would not matter whether to use [SWT](https://www.eclipse.org/swt/) or [Swing](https://docs.oracle.com/javase/tutorial/uiswing/) as they both provide support for building non-native components (in addition to native widgets in the case of [SWT](https://www.eclipse.org/swt/)).

[Glimmer DSL for Swing](https://rubygems.org/gems/glimmer-dsl-swing) aims to supercharge productivity and maintainability in developing [Swing](https://docs.oracle.com/javase/tutorial/uiswing/) applications by providing a DSL similar to [Glimmer DSL for SWT](https://github.com/AndyObtiva/glimmer-dsl-swt) having:
- Declarative DSL syntax that visually maps to the GUI widget hierarchy
- Convention over configuration via smart defaults and automation of low-level details
- Requiring the least amount of syntax possible to build GUI
- Custom Keyword support
- Bidirectional Data-Binding to declaratively wire and automatically synchronize GUI with Business Models
- Scaffolding for new custom widgets, apps, and gems
- Native-Executable packaging on Mac, Windows, and Linux.

Hello, World!

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
- JRuby 9.2.20.1 (supporting Ruby 2.5.x syntax) (get via [RVM](http://rvm.io) on Mac and Linux by running `rvm install jruby-9.3.1.0`; On Windows, find at [https://www.jruby.org/download](https://www.jruby.org/download))

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

For actual application development outside of simple demos, mixin the `Glimmer` module into a custom application class instead:

```ruby
require 'glimmer-dsl-swing'

class SomeGlimmerApplication
  include Glimmer
  
  def launch
    jframe('Hello, World!') {
      jlabel('Hello, World!')
    }.show
  end
end

SomeGlimmerApplication.new.launch
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