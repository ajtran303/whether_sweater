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
            eight_hour: forecast.eight_hour,
            five_day: forecast.five_day
          }
        }
      }
    }
  end
end
