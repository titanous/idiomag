module Idiomag
  class Artist
    include REST
    include Parser
    
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
        info_data = fetch('artist/info', {:artist => @artist})
        @links = info_data['links']['url']
      
        @related = {}
        info_data['related']['artist'].each {|a| @related[a['name']] = a['links']['url'][0] }
      end
    
      def get_tags
        tag_data = fetch('artist/tags', {:artist => @artist})
      
        @tags = {}
        tag_data['profile']['tag'].each {|t| @tags[t['name']] = t['value']}
        @tags.keys_to_sym!
      end
    
      def get_articles
        @articles = parse_articles(fetch('artist/articles', {:artist => @artist}))
      end
    
      def get_photos
        @photos = parse_photos(fetch('artist/photos', {:artist => @artist}))
      end
    
      def get_videos
        @videos = parse_videos(fetch('artist/videos', {:artist => @artist}))
      end
    
      def get_playlist
        @playlist = parse_playlist(fetch('artist/playlist', {:artist => @artist}))
      end
  end
end