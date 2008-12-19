require 'rake'
require 'rake/rdoctask'
require 'rcov/rcovtask'
require 'spec/rake/spectask'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = 'idiomag'
    s.summary = 'wrapper for the idiomag api'
    s.email = 'jon335@gmail.com'
    s.homepage = 'http://github.com/titanous/idiomag'
    s.authors = ['Jonathan Rudenberg']
    s.add_dependency('httparty', '>= 0.2.2')
  end
rescue LoadError
  puts 'Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com'
end

Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'doc'
  rdoc.title    = 'idiomag'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

desc 'Run all specs with rcov'
Rcov::RcovTask.new do |t|
  t.test_files = FileList['spec/*_spec.rb']
  t.rcov_opts = ['--exclude', 'spec']
  t.verbose = true
end

task :default => :rcov