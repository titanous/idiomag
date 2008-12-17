module Idiomag
  API_URL = 'http://www.idiomag.com/api/'
  
  class Base
    class << self
      attr_accessor :api_key
    end
  end
end