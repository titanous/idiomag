module Idiomag
  class REST
    def self.fetch(resource, query={}, parse=true)
      raise ArgumentError, 'api key missing' if Base.api_key.blank?
      
      options = {:query => {:key => Base.api_key}}
      options[:query].merge!(query)
      options[:format] = :json if parse
      HTTParty.get(API_URL + resource + "/json", options)
    end
  end
end