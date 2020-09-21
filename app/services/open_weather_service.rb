class OpenWeatherService
  def self.get_forecast(latitude, longitude)
    conn.get '/data/2.5/onecall' do |request|
      request.params[:units] = 'imperial'
      request.params[:exclude] = 'minutely'
      request.params[:lat] = latitude
      request.params[:lon] = longitude
    end
  end

  def self.conn
    @conn ||= Faraday.new ENV['OPEN_WEATHER_URL'] do |f|
      f.params[:appid] = ENV['OPEN_WEATHER_KEY']
    end
  end
end
