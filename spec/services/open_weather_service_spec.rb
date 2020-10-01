require 'rails_helper'

RSpec.describe OpenWeatherService do
  it 'can get_forecast' do
    VCR.use_cassette 'can get_forecast' do
      latitude = 40.015831
      longitude = -105.27927
      forecast = OpenWeatherService.get_forecast latitude, longitude

      forecast_keys = [:lat, :lon, :timezone, :timezone_offset, :current, :hourly, :daily, :alerts]

      expect(forecast).to be_a Hash
      expect(forecast.keys).to match_array forecast_keys
      expect(forecast[:lat]).to be_a Numeric
      expect(forecast[:lon]).to be_a Numeric
      expect(forecast[:timezone]).to be_a String
      expect(forecast[:timezone_offset]).to be_a Numeric
      expect(forecast[:current]).to be_a Hash
      expect(forecast[:hourly]).to be_a Array
      expect(forecast[:hourly].first).to be_a Hash
      expect(forecast[:daily]).to be_a Array
      expect(forecast[:daily].first).to be_a Hash
    end
  end
end
