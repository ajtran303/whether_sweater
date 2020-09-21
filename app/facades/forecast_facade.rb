class ForecastFacade
  def initialize params
    @location_params = params[:location]
  end

  def date_time
    EpochTimeConverter.date_time forecast[:current][:dt], forecast[:timezone_offset]
  end

  def location
    @location ||= {
      city: geocoding[:results][0][:locations][0][:adminArea5],
      state: geocoding[:results][0][:locations][0][:adminArea3],
      country: geocoding[:results][0][:locations][0][:adminArea1],
      latitude: geocoding[:results][0][:locations][0][:latLng][:lat],
      longitude: geocoding[:results][0][:locations][0][:latLng][:lng]
    }
  end

  def current_weather
    @current_weather ||= {
      condition: forecast[:current][:weather][0][:main],
      temperature: forecast[:current][:temp],
      high: forecast[:daily][0][:temp][:max],
      low: forecast[:daily][0][:temp][:min],
      feels_like: forecast[:current][:feels_like],
      humidity: forecast[:current][:humidity],
      visibility: nil,
      uv_index: forecast[:current][:uvi],
      sunrise: sunrise,
      sunset: sunset
    }
  end

  def eight_hour
    # binding.pry
  end

  private

  def sunrise
    sunrise = EpochTimeConverter.new forecast[:current][:sunrise], forecast[:timezone_offset]
    "#{sunrise.hour}:#{sunrise.minute} #{sunrise.meridiem}"
  end

  def sunset
    sunset = EpochTimeConverter.new forecast[:current][:sunset], forecast[:timezone_offset]
    "#{sunset.hour}:#{sunset.minute} #{sunset.meridiem}"
  end

  def geocoding
    @geocoding ||= parse_body MapQuestService.locate @location_params
  end

  def forecast
    @forecast ||= parse_body OpenWeatherService.get_forecast location[:latitude], location[:longitude]
  end

  def parse_body json
    JSON.parse json.body, symbolize_names: true
  end
end
