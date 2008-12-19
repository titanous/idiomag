require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'idiomag'))

Idiomag::Base.api_key = 'foo' # get this @ idiomag.com/api
artist = Idiomag::Artist.new('Anberlin')

p "#{artist.name}'s URLs:"
artist.links.each {|link| p link}

p "#{artist.name}'s related artists:"
artist.related.each {|name,link| p "#{name}: #{link}"}

p "#{artist.name}'s tags:"
artist.tags.each {|tag,value| p "#{tag} = #{value}"}

p "#{artist.name}'s recent articles:"
artist.articles.each {|article| p "#{article[:title]} on #{article[:date].strftime('%A')}"}

p "#{artist.name}'s photos:"
artist.photos.each {|photo| p photo[:url]}

p "#{artist.name}'s videos"
artist.videos.each {|video| p "#{video[:title]} - #{video[:location]}"}

p "#{artist.name}'s tracks"
artist.tracks.each {|track| p "#{track[:title]} - #{track[:location]}"}