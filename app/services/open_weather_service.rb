class OpenWeatherService < ConnectionService
  def self.get_forecast(latitude, longitude)
    coordinates = {latitude: latitude, longitude: longitude}
    parse_body forecast.call coordinates
  end

  private

  def self.forecast
    proc do |coordinates|
      conn.get '/data/2.5/onecall' do |request|
        request.params[:units] = 'imperial'
        request.params[:exclude] = 'minutely'
        request.params[:lat] = coordinates[:latitude]
        request.params[:lon] = coordinates[:longitude]
      end
    end
  end

  def self.conn
    @conn ||= Faraday.new ENV['OPEN_WEATHER_URL'] do |f|
      f.params[:appid] = ENV['OPEN_WEATHER_KEY']
    end
  end
end
