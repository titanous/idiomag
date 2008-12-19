require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'idiomag'))

Idiomag::Base.api_key = 'foo' # get this @ idiomag.com/api
articles = Idiomag::Articles.new
articles.get(:latest, :featured) # prefetch data (optional)

puts "latest articles:"
articles.latest.each {|article| puts "#{article[:title]} on #{article[:date].strftime('%A')}"}
puts "\n\n"

puts "featured articles:"
articles.featured.each {|article| puts "#{article[:title]} on #{article[:date].strftime('%A')}"}