class OpenWeatherService < ConnectionService
  def self.get_forecast latitude, longitude
    forecast = conn.get '/data/2.5/onecall' do |request|
      request.params[:units] = 'imperial'
      request.params[:exclude] = 'minutely'
      request.params[:lat] = latitude
      request.params[:lon] = longitude
    end
    parse_body forecast
  end

  private

  def self.conn
    @conn ||= Faraday.new ENV['OPEN_WEATHER_URL'] do |f|
      f.params[:appid] = ENV['OPEN_WEATHER_KEY']
    end
  end
end
