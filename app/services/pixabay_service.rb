class PixabayService < ConnectionService
  def self.find_photograph query_params
    photo = Faraday.get '/api/' do |request|
      request.params[:q] = query_params[:location]
      request.params[:image_type] = 'photo'
      request.params[:safesearch] = true
    end
  end

  private

  def self.conn
    @conn ||= Faraday.new ENV['PIXABAY_URL'] do |f|
      f.params[:key] = ENV['PIXABAY_KEY']
    end
  end
end
