module Idiomag
  module Parser
    def parse_articles(article_data)
      articles = article_data['articles']
      articles.each do |a|
        a.rename_key!('sourceUrl', 'source_url')
        a.keys_to_sym!
        a[:date] = Time.parse(a[:date])
      end
    end
    
    def parse_photos(photo_data)
      photos = photo_data['photos']
      photos.each do |p|
        p.keys_to_sym!
        p[:date] = Time.parse(p[:date])
      end
    end
    
    def parse_videos(video_data)    
      videos = video_data['tracks']
      videos.each {|v| v.keys_to_sym!}
    end
    
    def parse_playlist(playlist_data)
      playlist = playlist_data['tracks']
      playlist.each {|v| v.keys_to_sym!}
    end
  end
end