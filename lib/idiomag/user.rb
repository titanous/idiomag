module Idiomag
  class User
    attr_accessor :user
    
    def initialize(user)
      raise ArgumentError if user.blank?
      @user = user
    end
    
    def get(*args)
      args.each do |action|
        case action
        when :info
          get_info
        when :articles
          get_articles
        when :loved_articles
          get_loved_articles
        when :photos
          get_photos
        when :videos
          get_videos
        when :playlist, :tracks
          get_playlist
        else
          raise ArgumentError
        end
      end
    end
    
    def respond_to?(method)
      case method
      when :name,:email,:url,:tags,:artists,:articles,:loved_articles,:photos,:videos,:playlist,:tracks
        true
      else
        super
      end
    end
    
    def method_missing(method, *args)  
      case method
      when :name
        get_info if @name.nil?
        @name
      when :email
        get_info if @email.nil?
        @email
      when :url
        get_info if @url.nil?
        @url
      when :artists
        get_info if @artists.nil?
        @artists
      when :tags
        get_info if @tags.nil?
        @tags
      when :articles
        get_articles if @articles.nil?
        @articles
      when :loved_articles
        get_loved_articles if @loved_articles.nil?
        @loved_articles
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
        info_data = REST.fetch('user/info', {:user => @user})
        
        @name = info_data['name']
        @email = info_data['email_sha1']
        @url = info_data['url']
        
        @artists = {}
        info_data['artists']['artist'].each {|a| @artists[a['title']] = a['value'] } if !info_data['artists'].blank?
        
        @tags = {}
        info_data['tags']['tag'].each {|t| @tags[t['name']] = t['value']} if !info_data['tags'].blank?
        @tags.keys_to_sym!
      end
      
      def get_articles
        @articles = Parser.parse_articles(REST.fetch('user/articles', :user => @user))
      end
      
      def get_loved_articles
        @loved_articles = Parser.parse_articles(REST.fetch('user/lovedarticles', :user => @user))
      end
      
      def get_photos
        @photos = Parser.parse_photos(REST.fetch('user/photos', :user => @user))
      end
      
      def get_videos
        @videos = Parser.parse_videos(REST.fetch('user/videos', :user => @user))
      end
      
      def get_playlist
        @playlist = Parser.parse_playlist(REST.fetch('user/playlist', :user => @user))
      end
  end
end