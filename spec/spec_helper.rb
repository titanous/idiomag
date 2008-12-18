require 'rubygems'
require 'json'
begin
  require 'spec'
rescue LoadError
  gem 'rspec'
  require 'spec'
end
 
dir = File.dirname(__FILE__)
 
$:.unshift(File.join(dir, '/../lib/'))
require dir + '/../lib/idiomag'

Fixtures = File.dirname(__FILE__) + '/fixtures/'