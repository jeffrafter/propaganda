require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "propaganda"
    gem.summary = %Q{Generate PDFs from HTML. Generate them from Markdown and Textile. Take over the world.}
    gem.description = %Q{Propaganda uses Apache FOP to convert html to PDF using a series of stylesheets. Propaganda can also format textile and markdown documents. }
    gem.email = "jeff@socialrange.org"
    gem.homepage = "http://github.com/jeffrafter/propaganda"
    gem.authors = ["Jeff Rafter"]
    gem.files = FileList["[A-Z]*", "{bin,java,lib,templates,test}/**/*"] 
    gem.add_dependency "BlueCloth", ">= 1.0.0"
    gem.add_dependency "RedCloth", ">= 4.1.1"
    gem.add_dependency "rjb", ">= 1.2.0"
    gem.add_development_dependency "thoughtbot-shoulda", ">= 0"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/*_test.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "propaganda #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
