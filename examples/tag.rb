require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'idiomag'))

Idiomag::Base.api_key = 'foo' # get this @ idiomag.com/api
tag = Idiomag::Tag.new(:alternative_rock)
tag.get(:artists, :articles, :photos, :videos, :tracks) # prefetch data (optional)

puts "artists for #{tag.name}:"
tag.artists.each {|name,value| puts "#{name}: #{value}"}
puts "\n\n"

puts "recent articles for #{tag.name}:"
tag.articles.each {|article| puts "#{article[:title]} on #{article[:date].strftime('%A')}"}
puts "\n\n"

puts "photos for #{tag.name}:"
tag.photos.each {|photo| puts photo[:url]}
puts "\n\n"

puts "videos for #{tag.name}:"
tag.videos.each {|video| puts "#{video[:title]} - #{video[:location]}"}
puts "\n\n"

puts "tracks for #{tag.name}:"
tag.tracks.each {|track| puts "#{track[:title]} - #{track[:location]}"}