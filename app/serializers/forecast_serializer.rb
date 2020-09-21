class ForecastSerializer
  def self.to_json_api(forecast_params)
    { data:
      { type:'forecast',
        id: nil,
        attributes: {
          location: nil,
          current_weather: nil,
          forecast: {
            eight_hour: nil,
            five_day: nil
          }
        }
      }
    }
  end
end
