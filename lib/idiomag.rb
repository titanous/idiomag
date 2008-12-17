$:.unshift File.dirname(__FILE__)

require 'rubygems'
gem 'httparty', '0.2.2'
require 'httparty'

gem 'json', '1.1.3'
require 'json'

require 'time'

require 'idiomag/version'
require 'idiomag/base'
require 'idiomag/helpers'
require 'idiomag/rest'
require 'idiomag/artist'
require 'idiomag/articles'
require 'idiomag/tag'