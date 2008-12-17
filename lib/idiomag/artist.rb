module Idiomag
  class Artist
    include REST
    
    def initialize(artist)
      raise ArgumentError if artist.blank?
      @artist = artist
    end
    
    def get(*args)
      args.each do |action|
        case action
        when :info
          get_info
        when :tags
          get_tags
        when :articles
          get_articles
        when :photos
          get_photos
        when :videos
          get_videos
        when :playlist, :tracks
          get_playlist
        end
      end
    end
    
    def respond_to?(method)
      case method
      when :links,:related,:tags,:articles,:photos,:videos,:playlist,:tracks
        true
      else
        super
      end
    end
    
    def method_missing(method, *args)  
      case method
      when :links
        get_info if @links.nil?
        @links
      when :related
        get_info if @related.nil?
        @related
      when :tags
        get_tags if @tags.nil?
        @tags
      when :articles
        get_articles if @articles.nil?
        @articles
      when :photos
        get_photos if @photos.nil?
        @photos
      when :videos
        get_videos if @videos.nil?
        @videos
      when :playlist, :tracks
        get_playlist if @playlist.nil?
        @playlist
      else
        super
      end
    end
    
    private
    
      def get_info
        @info_data = fetch('artist/info', {:artist => @artist})
        @links = @info_data['links']['url']
      
        @related = {}
        @info_data['related']['artist'].each {|a| @related[a['name']] = a['links']['url'][0] }
      end
    
      def get_tags
        @tag_data = fetch('artist/tags', {:artist => @artist})
      
        @tags = {}
        @tag_data['profile']['tag'].each {|t| @tags[t['name']] = t['value']}
        @tags.keys_to_sym!
      end
    
      def get_articles
        @article_data = fetch('artist/articles', {:artist => @artist})
      
        @articles = @article_data['articles']
        @articles.each do |a|
          a.rename_key!('sourceUrl', 'source_url')
          a.keys_to_sym!
          a[:date] = Time.parse(a[:date])
        end
      end
    
      def get_photos
        @photo_data = fetch('artist/photos', {:artist => @artist})
      
        @photos = @photo_data['photos']
        @photos.each do |p|
          p.keys_to_sym!
          p[:date] = Time.parse(p[:date])
        end
      end
    
      def get_videos
        @video_data = fetch('artist/videos', {:artist => @artist})
      
        @videos = @video_data['tracks']
        @videos.each {|v| v.keys_to_sym!}
      end
    
      def get_playlist
        @playlist_data = fetch('artist/playlist', {:artist => @artist})
      
        @playlist = @playlist_data['tracks']
        @playlist.each {|v| v.keys_to_sym!}
      end
  end
end