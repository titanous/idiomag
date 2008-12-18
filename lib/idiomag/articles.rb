module Idiomag
  class Articles
      def get(*args)
        args.each do |action|
          case action
          when :latest
            get_latest
          when :featured
            get_featured
          else
            raise ArgumentError
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
          @latest = Parser.parse_articles(REST.fetch('articles/latest'))
        end
        
        def get_featured
          @featured = Parser.parse_articles(REST.fetch('articles/featured'))
        end
  end
end