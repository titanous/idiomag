module Idiomag
  module REST    
    def fetch(resource, query={})
      @options = {:query => {:key => Base.api_key}}
      @options[:query].merge!(query)
      JSON.parse(HTTParty.get(API_URL + resource + "/json", @options))
    end
  end
end