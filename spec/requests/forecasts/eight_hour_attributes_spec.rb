require 'rails_helper'

RSpec.describe 'Forecast response has current weather data' do
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

    expect(forecast[:data][:attributes][:forecast]).to have_key :eight_hour
    eight_hour = forecast[:data][:attributes][:forecast][:eight_hour]

    expect(eight_hour).to be_a Array
    expect(eight_hour.size).to eq 8

    expect(eight_hour.first).to have_key :hour
    expect(eight_hour.first).to have_key :condition
    expect(eight_hour.first).to have_key :temperature
  end
end
