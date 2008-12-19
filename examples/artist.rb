require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'idiomag'))

Idiomag::Base.api_key = 'foo' # get this @ idiomag.com/api
artist = Idiomag::Artist.new('Anberlin')
artist.get(:info, :tags, :articles, :photos, :videos, :tracks) # prefetch data (optional)

puts "#{artist.name}'s URLs:"
artist.links.each {|link| puts link}
puts "\n\n"

puts "#{artist.name}'s related artists:"
artist.related.each {|name,link| puts "#{name}: #{link}"}
puts "\n\n"

puts "#{artist.name}'s tags:"
artist.tags.each {|tag,value| puts "#{tag} = #{value}"}
puts "\n\n"

puts "#{artist.name}'s recent articles:"
artist.articles.each {|article| puts "#{article[:title]} on #{article[:date].strftime('%A')}"}
puts "\n\n"

puts "#{artist.name}'s photos:"
artist.photos.each {|photo| puts photo[:url]}
puts "\n\n"

puts "#{artist.name}'s videos:"
artist.videos.each {|video| puts "#{video[:title]} - #{video[:location]}"}
puts "\n\n"

puts "#{artist.name}'s tracks:"
artist.tracks.each {|track| puts "#{track[:title]} - #{track[:location]}"}