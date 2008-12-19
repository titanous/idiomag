module Idiomag
  class InvalidResult < StandardError; end;

  class REST
    def self.fetch(resource, query={}, parse=true)
      raise ArgumentError, 'api key missing' if Base.api_key.blank?
      
      options = {:query => {:key => Base.api_key}}
      options[:query].merge!(query)
      options[:format] = :json if parse
      begin
        data = HTTParty.get(API_URL + resource + "/json", options)
      rescue Net::HTTPServerException => e
          raise ArgumentError, 'invalid user, artist or tag' if e.message =~ /400/
      end
      raise InvalidResult if data.blank?
      data
    end
  end
end