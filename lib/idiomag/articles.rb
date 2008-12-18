module Idiomag
  class Articles
    include REST
    include Parser
    
      def get(*args)
        args.each do |action|
          case action
          when :latest
            get_latest
          when :featured
            get_featured
          end
        end
      end

      def respond_to?(method)
        case method
        when :featured,:latest
          true
        else
          super
        end
      end

      def method_missing(method, *args)  
        case method
        when :latest
          get_latest if @latest.nil?
          @latest
        when :featured
          get_featured if @featured.nil?
          @featured
        else
          super
        end
      end

      private

        def get_latest
          @latest = parse_articles(fetch('articles/latest'))
        end
        
        def get_featured
          @featured = parse_articles(fetch('articles/featured'))
        end
  end
end