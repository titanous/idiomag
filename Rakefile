require 'rake'
require 'rake/rdoctask'
require 'rcov/rcovtask'
require 'spec/rake/spectask'

WEBSITE_PATH = 'titanous@rubyforge.org:/var/www/gforge-projects/idiomag'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = 'idiomag'
    s.summary = 'wrapper for the idiomag api'
    s.description = 'wrapper for the idiomag api'
    s.email = 'jon335@gmail.com'
    s.homepage = 'http://idiomag.rubyforge.org'
    s.authors = ['Jonathan Rudenberg']
    s.add_dependency('httparty', '>= 0.2.2')
    s.rubyforge_project = 'idiomag'
    s.files = FileList['lib/**/*.rb', 'bin/*', '[A-Z]*', 'spec/**/*'].to_a
    s.has_rdoc = true
    s.rdoc_options = ['--line-numbers', '--inline-source', '--title', 'idiomag', '--main', 'README.rdoc']
    s.extra_rdoc_files = ['README.rdoc']
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

desc 'Upload website files to rubyforge'
task :website do
  sh %{rsync -av website/ #{WEBSITE_PATH}}
  Rake::Task['website_docs'].invoke
end

task :website_docs do
  Rake::Task['rdoc'].invoke
  sh %{rsync -av doc/ #{WEBSITE_PATH}/docs}
end