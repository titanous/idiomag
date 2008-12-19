require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'idiomag'))

Idiomag::Base.api_key = 'foo' # get this @ idiomag.com/api
user = Idiomag::User.new('Titanous')
user.get(:info, :articles, :loved_articles, :photos, :videos, :tracks) # prefetch data (optional)

puts "#{user.name}'s info:"
puts "email hash: #{user.email}"
puts "profile url: #{user.url}"
puts "\n"

puts "#{user.name}'s tags:"
user.tags.each {|tag,value| puts "#{tag} = #{value}"}
puts "\n"

puts "#{user.name}'s artists:"
user.artists.each {|name,value| puts "#{name}: #{value}"}
puts "\n\n"

puts "#{user.name}'s recent articles:"
user.articles.each {|article| puts "#{article[:title]} on #{article[:date].strftime('%A')}"}
puts "\n\n"

puts "#{user.name}'s loved articles:"
user.loved_articles.each {|article| puts "#{article[:title]} on #{article[:date].strftime('%A')}"}
puts "\n\n"

puts "#{user.name}'s photos:"
user.photos.each {|photo| puts photo[:url]}
puts "\n\n"

puts "#{user.name}'s videos:"
user.videos.each {|video| puts "#{video[:title]} - #{video[:location]}"}
puts "\n\n"

puts "#{user.name}'s tracks:"
user.tracks.each {|track| puts "#{track[:title]} - #{track[:location]}"}