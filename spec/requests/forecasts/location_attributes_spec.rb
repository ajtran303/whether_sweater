require 'rails_helper'

RSpec.describe 'Forecast response has location data' do
  it 'exists' do
    forecast_params = {
      'location' => 'denver,co'
    }

    headers = {
      'CONTENT_TYPE' => 'application/vnd.api+json',
      'ACCEPT' => 'application/vnd.api+json'
    }

    get '/api/v1/forecast', headers: headers, params: forecast_params
    forecast = parse_body(response)

    expect(forecast[:data][:attributes]).to have_key :location
    expect(forecast[:data][:attributes][:location].keys.size).to eq 3
    expect(forecast[:data][:attributes][:location]).to have_key :city
    expect(forecast[:data][:attributes][:location]).to have_key :state
    expect(forecast[:data][:attributes][:location]).to have_key :country
  end
end
