class PixabayService < ConnectionService
  def self.find_photograph query_params
    location_photo = parse_body search_pixabay.call query_params[:location]
    return location_photo[:hits][0] unless location_photo[:hits].empty?

    weather_photo = parse_body search_pixabay.call query_params[:weather]
    weather_photo[:hits][0]
  end

  def self.search_pixabay
    proc do |query_param|
      conn.get '/api/' do |request|
        request.params[:q] = query_param
        request.params[:image_type] = 'photo'
        request.params[:safesearch] = 'true'
      end
    end
  end

  private

  def self.conn
    @conn ||= Faraday.new ENV['PIXABAY_URL'] do |f|
      f.params[:key] = ENV['PIXABAY_KEY']
    end
  end
end
