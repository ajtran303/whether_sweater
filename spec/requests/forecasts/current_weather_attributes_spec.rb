require 'rails_helper'

RSpec.describe 'Forecast response has current weather data' do
  it 'exists' do
    VCR.use_cassette 'Forecast response has current weather data' do
      forecast_params = {
        'location' => 'denver,co'
      }

      headers = {
        'CONTENT_TYPE' => 'application/json',
        'ACCEPT' => 'application/json'
      }

      get '/api/v1/forecast', headers: headers, params: forecast_params
      forecast = parse_body(response)

      expect(forecast[:data][:attributes]).to have_key :current_weather

      current_weather = forecast[:data][:attributes][:current_weather]
      expect(current_weather.keys.size).to eq 10

      expect(current_weather).to have_key :condition
      expect(current_weather).to have_key :temperature
      expect(current_weather).to have_key :high
      expect(current_weather).to have_key :low
      expect(current_weather).to have_key :feels_like
      expect(current_weather).to have_key :humidity
      expect(current_weather).to have_key :visibility
      expect(current_weather).to have_key :uv_index
      expect(current_weather).to have_key :sunrise
      expect(current_weather).to have_key :sunset
    end
  end
end
