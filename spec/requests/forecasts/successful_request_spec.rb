require 'rails_helper'

RSpec.describe 'Forecast Endpoint can respond to correct request type' do
  it 'responds to application/json with a success' do
    VCR.use_cassette 'success' do
      forecast_params = {
        'location' => 'denver,co'
      }

      headers = {
        'CONTENT_TYPE' => 'application/json',
        'ACCEPT' => 'application/json'
      }

      get '/api/v1/forecast', headers: headers, params: forecast_params

      expect(response.media_type).to eq('application/json')
      expect(response.status).to eq(200)
      expect(response).to be_successful

      forecast = parse_body(response)

      expect(forecast).to_not have_key :errors
      expect(forecast).to have_key :data

      expect(forecast[:data]).to have_key :type
      expect(forecast[:data]).to have_key :id
      expect(forecast[:data]).to have_key :attributes
      expect(forecast[:data].keys.size).to eq 3

      expect(forecast[:data][:type]).to eq 'forecast'
      expect(forecast[:data][:id]).to be_nil
      expect(forecast[:data][:attributes]).to be

      expect(forecast[:data][:attributes]).to have_key :location
      expect(forecast[:data][:attributes]).to have_key :current_weather
      expect(forecast[:data][:attributes]).to have_key :forecast
      expect(forecast[:data][:attributes]).to have_key :date_time
      expect(forecast[:data][:attributes].keys.size).to eq 4

      expect(forecast[:data][:attributes][:forecast]).to have_key :eight_hour
      expect(forecast[:data][:attributes][:forecast]).to have_key :five_day
    end
  end
end
