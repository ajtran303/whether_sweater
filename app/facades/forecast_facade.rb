class ForecastFacade
  def self.build_facade params
    forecast = new location: params[:location]
    { data:
      { type:'forecast',
        id: nil,
        attributes: {
          date_time: forecast.date_time,
          location: forecast.location,
          current_weather: forecast.current_weather,
          forecast: {
            eight_hour: forecast.eight_hour,
            five_day: forecast.five_day
          }
        }
      }
    }
  end

  def initialize params
    @location_params = params[:location]
  end

  def date_time
    EpochTimeConverter.date_time forecast[:current][:dt], offset
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
    forecast[:hourly][1..8].map do |hourly_forecast|
      time = EpochTimeConverter.new hourly_forecast[:dt], offset
      {
        hour: "#{time.hour} #{time.meridiem}",
        condition: hourly_forecast[:weather][0][:main],
        temperature: hourly_forecast[:temp]
      }
    end
  end

  def five_day
    forecast[:daily][1..5].map do |daily_forecast|
      date = EpochTimeConverter.new daily_forecast[:dt], offset
      {
        day_of_week: date.day_of_week,
        condition: daily_forecast[:weather][0][:main],
        precipitation: "#{daily_forecast[:rain] || '0'} mm",
        high: daily_forecast[:temp][:max],
        low: daily_forecast[:temp][:max]
      }
    end
  end

  private

  def offset
    forecast[:timezone_offset]
  end

  def sunrise
    sunrise = EpochTimeConverter.new forecast[:current][:sunrise], offset
    "#{sunrise.hour}:#{sunrise.minute} #{sunrise.meridiem}"
  end

  def sunset
    sunset = EpochTimeConverter.new forecast[:current][:sunset], offset
    "#{sunset.hour.to_i - 12}:#{sunset.minute} #{sunset.meridiem}"
  end

  def geocoding
    @geocoding ||= MapQuestService.locate @location_params
  end

  def forecast
    @forecast ||= OpenWeatherService.get_forecast location[:latitude], location[:longitude]
  end
end
