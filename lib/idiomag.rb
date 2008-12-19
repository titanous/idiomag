$:.unshift File.dirname(__FILE__)

require 'rubygems'
gem 'httparty'
require 'httparty'

require 'time'

require 'idiomag/base'
require 'idiomag/helpers'
require 'idiomag/parser'
require 'idiomag/rest'
require 'idiomag/artist'
require 'idiomag/articles'
require 'idiomag/tag'
require 'idiomag/user'
require 'idiomag/recommendation'