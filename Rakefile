# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'
require 'juwelier'
Juwelier::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://guides.rubygems.org/specification-reference/ for more options
  gem.name = "glimmer-dsl-swing"
  gem.homepage = "http://github.com/AndyObtiva/glimmer-dsl-swing"
  gem.license = "MIT"
  gem.summary = %Q{Glimmer DSL for Swing}
  gem.description = %Q{Glimmer DSL for Swing (JRuby Swing Desktop Development GUI Library) - Enables development of desktop applications using Java Swing, Java AWT, JFC (Java Foundation Classes), and Java 2D, including vector graphics and AWT geometry.}
  gem.email = "andy.am@gmail.com"
  gem.authors = ["Andy Maleh"]
  gem.executables = ['girb']
  gem.files = ['README.md', 'CHANGELOG.md', 'VERSION', 'LICENSE.txt', 'glimmer-dsl-swing.gemspec', 'bin/**/*', 'lib/**/*', 'icons/**/*', 'samples/**/*']
  gem.require_paths = ['lib', '.']

  # dependencies defined in Gemfile
end
Juwelier::RubygemsDotOrgTasks.new
require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

desc "Code coverage detail"
task :simplecov do
  ENV['COVERAGE'] = "true"
  Rake::Task['spec'].execute
end

task :default => :spec

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "glimmer-dsl-swing #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
