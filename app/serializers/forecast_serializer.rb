class ForecastSerializer
  def self.to_json_api(forecast)
    { data:
      { type:'forecast',
        id: nil,
        attributes: {
          date_time: forecast.date_time,
          location: forecast.location,
          current_weather: forecast.current_weather,
          forecast: {
            eight_hour: nil,
            five_day: nil
          }
        }
      }
    }
  end
end
