module Idiomag
  class Tag
    include REST
    
    def initialize(tag)
      raise ArgumentError if tag.blank?
      @tag = tag.to_s.gsub(/_/, ' ')
    end
    
    def get(*args)
      args.each do |action|
        case action
        when :articles
          get_articles
        when :photos
          get_photos
        when :videos
          get_videos
        when :playlist, :tracks
          get_playlist
        when :artists
          get_artists
        when :list
          get_list
        end
      end
    end
    
    def respond_to?(method)
      case method
      when :articles,:photos,:videos,:playlist,:tracks,:artists,:list
        true
      else
        super
      end
    end
    
    def method_missing(method, *args)  
      case method
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
      when :artists
        get_artists if @artists.nil?
        @artists
      when :list
        get_list if @list.nil?
        @list
      else
        super
      end
    end
    
    def self.list
      Tag.new('foo').list
    end
    
    private
    
      def get_articles
        @article_data = fetch('tag/articles', {:tag => @tag})
      
        @articles = @article_data['articles']
        @articles.each do |a|
          a.rename_key!('sourceUrl', 'source_url')
          a.keys_to_sym!
          a[:date] = Time.parse(a[:date])
        end
      end
    
      def get_photos
        @photo_data = fetch('tag/photos', {:tag => @tag})
      
        @photos = @photo_data['photos']
        @photos.each do |p|
          p.keys_to_sym!
          p[:date] = Time.parse(p[:date])
        end
      end
    
      def get_videos
        @video_data = fetch('tag/videos', {:tag => @tag})
      
        @videos = @video_data['tracks']
        @videos.each {|v| v.keys_to_sym!}
      end
    
      def get_playlist
        @playlist_data = fetch('tag/playlist', {:tag => @tag})
      
        @playlist = @playlist_data['tracks']
        @playlist.each {|v| v.keys_to_sym!}
      end
      
      def get_artists
        @artist_data = fetch('tag/artist', {:tag => @tag})
      
        @artists = {}
        @artist_data['profile']['artist'].each {|t| @artists[t['title']] = t['value']}
      end
      
      def get_list
        @list_data = fetch('tags', {}, false)
        
        @list = @list_data.split("\n")
        @list.map! {|t| t.strip.downcase.gsub(/ /, '_').to_sym}
      end
  end
end