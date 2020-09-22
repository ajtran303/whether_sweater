require 'rails_helper'

RSpec.describe 'Forecast response has location data' do
  it 'exists' do
    VCR.use_cassette 'Forecast response has location data' do
      forecast_params = {
        'location' => 'denver,co'
      }

      headers = {
        'CONTENT_TYPE' => 'application/json',
        'ACCEPT' => 'application/json'
      }

      get '/api/v1/forecast', headers: headers, params: forecast_params
      forecast = parse_body(response)

      expect(forecast[:data][:attributes]).to have_key :location
      expect(forecast[:data][:attributes][:location].keys.size).to eq 5
      expect(forecast[:data][:attributes][:location]).to have_key :city
      expect(forecast[:data][:attributes][:location]).to have_key :state
      expect(forecast[:data][:attributes][:location]).to have_key :country
      expect(forecast[:data][:attributes][:location]).to have_key :latitude
      expect(forecast[:data][:attributes][:location]).to have_key :longitude
    end
  end
end
