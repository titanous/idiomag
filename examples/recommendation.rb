require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'idiomag'))

Idiomag::Base.api_key = 'foo' # get this @ idiomag.com/api
recommendation = Idiomag::Recommendation.new(:network => :lastfm, :user => 'titanous')
recommendation.get(:articles, :artists) # prefetch data (optional)

puts "recommended artists:"
recommendation.artists.each {|name,value| puts "#{name}: #{value}"}
puts "\n\n"

puts "recommended articles:"
recommendation.articles.each {|article| puts "#{article[:title]} on #{article[:date].strftime('%A')}"}