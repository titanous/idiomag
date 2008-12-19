module Idiomag
  class Recommendation
    ValidNetworks = [:lastfm,:mog,:ilike,:mystrands,:projectplaylist,:imeem,:pandora,:bebo,:myspace,:songza]
    
    def initialize(options)
      if !options[:network].blank? && !options[:user].blank?
        @user = options[:user]
        @network = options[:network]
        raise ArgumentError if !ValidNetworks.include?(@network)
        @query = {:network => @network,:user => @user}
      elsif !options[:apml].blank?
        @apml = options[:apml]
        @query = {:apml => @apml}
      elsif !options[:artists].blank? && options[:artists].is_a?(Array)
        @artist_list = options[:artists]
        @query = {:artists => @artist_list}
      else
        raise ArgumentError
      end
    end
    
    def get(*args)
      args.each do |action|
        case action
        when :articles
          get_articles
        when :artists
          get_artists
        else
          raise ArgumentError
        end
      end
    end
    
    def respond_to?(method)
      case method
      when :articles,:artists
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
      when :artists
        get_artists if @artists.nil?
        @artists
      else
        super
      end
    end
    
    private
    
      def get_articles
        @articles = Parser.parse_articles(REST.fetch('recommendation/articles', @query))
      end
      
      def get_artists
        artist_data = REST.fetch('recommendation/artists', @query)
        
        @artists = {}
        artist_data['artists'].each {|a| @artists[a['title']] = a['value'] }
      end
  end
end