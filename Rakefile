raise "jruby-hornetq must be built with JRuby: try again with `jruby -S rake'" unless defined?(JRUBY_VERSION)

require 'rake/clean'
require 'date'
require 'java'

desc "Build gem"
task :gem  do |t|
  gemspec = Gem::Specification.new do |s|
    s.name = 'jruby-hornetq'
    s.version = '0.1.0.alpha'
    s.author = 'Reid Morrison'
    s.email = 'rubywmq@gmail.com'
    s.homepage = 'http://www.reidmorrison.com/'
    s.date = Date.today.to_s
    s.description = 'JRuby-HornetQ is a Java and Ruby library that exposes the HornetQ Java API in a ruby friendly way. For JRuby only.'
    s.summary = 'JRuby interface into HornetQ'
    s.files = FileList["./**/*"].exclude('*.gem', './nbproject/*').map{|f| f.sub(/^\.\//, '')}
    s.has_rdoc = true
  end
  Gem::Builder.new(gemspec).build
end
