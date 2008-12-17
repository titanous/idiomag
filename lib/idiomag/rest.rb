module Idiomag
  module REST    
    def fetch(resource, query={}, parse=true)
      raise ArgumentError, 'api key missing' if Base.api_key.blank?
      
      @options = {:query => {:key => Base.api_key}}
      @options[:query].merge!(query)
      @data = HTTParty.get(API_URL + resource + "/json", @options)
      if parse
        JSON.parse(@data)
      else
        @data
      end
    end
  end
end