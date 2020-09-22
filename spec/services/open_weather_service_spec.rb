require 'rails_helper'

RSpec.describe OpenWeatherService do
  it 'can get_forecast' do
    VCR.use_cassette 'can get_forecast' do
      latitude = 40.015831
      longitude = -105.27927
      forecast = OpenWeatherService.get_forecast latitude, longitude

      forecast_keys = [:lat, :lon, :timezone, :timezone_offset, :current, :hourly, :daily]

      expect(forecast).to be_a Hash
      expect(forecast.keys).to match_array forecast_keys
    end
  end
end
