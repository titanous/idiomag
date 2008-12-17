require 'rubygems'
require 'rake'
require 'echoe'
require 'lib/idiomag/version'
 
Echoe.new('idiomag', Idiomag::Version) do |p|
  p.description = 'wrapper for the idiomag api'
  p.author = 'Jonathan Rudenberg'
  p.email = 'jon335@gmail.com'
  p.extra_deps = [['httparty', '0.2.2']]
end
 
desc 'Preps the gem for a new release'
task :prepare do
  %w[manifest build_gemspec].each do |task|
    Rake::Task[task].invoke
  end
end