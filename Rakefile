require 'rubygems'
require 'rake'
require 'echoe'
require 'lib/idiomag/version'

Rake::TaskManager.class_eval do
  def remove_task(task_name)
    @tasks.delete(task_name.to_s)
  end
end
 
def remove_task(task_name)
  Rake.application.remove_task(task_name)
end

Echoe.new('idiomag', Idiomag::Version) do |p|
  p.description = 'wrapper for the idiomag api'
  p.author = 'Jonathan Rudenberg'
  p.email = 'jon335@gmail.com'
  p.extra_deps = [['httparty', '0.2.2'], ['json', '1.1.3']]
end
 
desc 'Prep the gem for a new release'
task :prepare do
  %w[manifest build_gemspec].each do |task|
    Rake::Task[task].invoke
  end
end

remove_task :coverage # broken in echoe
desc 'Analyze code coverage with tests for coverage'
task :coverage do
  rm_f "coverage"
  system "rcov --text-summary -Ilib -x spec spec/*_spec.rb"
  system "open coverage/index.html" if PLATFORM['darwin']
end

desc 'Run specs'
task :spec do
  system "spec -c spec/*_spec.rb"
end