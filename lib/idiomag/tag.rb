module Idiomag
  class Tag    
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
        else
          raise ArgumentError
        end
      end
    end
    
    def respond_to?(method)
      case method
      when :articles,:photos,:videos,:playlist,:tracks,:artists,:list,:name
        true
      else
        super
      end
    end
    
    def method_missing(method, *args)  
      case method
      when :name
        @tag
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
        Tag.list
      else
        super
      end
    end
    
    class << self      
      def list
        if @list.blank?
          @list_data = REST.fetch('tags', {}, false)
      
          @list = @list_data.split("\n")
          @list.map! do |t|
            if t =~ /-/
              t.strip.downcase
            else
              t.strip.downcase.gsub(/ /, '_').to_sym
            end
          end
        else
          @list
        end
      end
    end
    
    private
    
      def get_articles
        @articles = Parser.parse_articles(REST.fetch('tag/articles', :tag => @tag))
      end
    
      def get_photos
        @photos = Parser.parse_photos(REST.fetch('tag/photos', :tag => @tag))
      end
    
      def get_videos
        @videos = Parser.parse_videos(REST.fetch('tag/videos', :tag => @tag))
      end
    
      def get_playlist
        @playlist = Parser.parse_playlist(REST.fetch('tag/playlist', :tag => @tag))
      end
      
      def get_artists
        artist_data = REST.fetch('tag/artists', :tag => @tag)
      
        @artists = {}
        artist_data['profile']['artist'].each {|t| @artists[t['title']] = t['value']}
      end
  end
end