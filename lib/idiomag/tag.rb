module Idiomag
  class Tag
    include REST
    include Parser
    
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
          @list_data = fetch('tags', {}, false)
      
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
        @articles = parse_articles(fetch('tag/articles', {:tag => @tag}))
      end
    
      def get_photos
        @photos = parse_photos(fetch('tag/photos', {:tag => @tag}))
      end
    
      def get_videos
        @videos = parse_videos(fetch('tag/videos', {:tag => @tag}))
      end
    
      def get_playlist
        @playlist = parse_playlist(fetch('tag/playlist', {:tag => @tag}))
      end
      
      def get_artists
        artist_data = fetch('tag/artist', {:tag => @tag})
      
        @artists = {}
        artist_data['profile']['artist'].each {|t| @artists[t['title']] = t['value']}
      end
  end
end