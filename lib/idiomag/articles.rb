module Idiomag
  class Articles
    include REST
    
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
          @latest_data = fetch('articles/latest')

          @latest = @latest_data['articles']
          @latest.each do |a|
            a.rename_key!('sourceUrl', 'source_url')
            a.keys_to_sym!
            a[:date] = Time.parse(a[:date])
          end
        end
        
        def get_featured
          @featured_data = fetch('articles/featured')

          @featured = @featured_data['articles']
          @featured.each do |a|
            a.rename_key!('sourceUrl', 'source_url')
            a.keys_to_sym!
            a[:date] = Time.parse(a[:date])
          end
        end
  end
end