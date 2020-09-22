require 'rails_helper'

RSpec.describe 'Forecast response has five day data' do
  it 'exists' do
    forecast_params = {
      'location' => 'denver,co'
    }

    headers = {
      'CONTENT_TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }

    get '/api/v1/forecast', headers: headers, params: forecast_params
    forecast = parse_body(response)

    expect(forecast[:data][:attributes][:forecast]).to have_key :five_day
    five_day = forecast[:data][:attributes][:forecast][:five_day]

    expect(five_day).to be_a Array
    expect(five_day.size).to eq 5

    expect(five_day.first).to have_key :day_of_week
    expect(five_day.first).to have_key :condition
    expect(five_day.first).to have_key :precipitation
    expect(five_day.first).to have_key :high
    expect(five_day.first).to have_key :low
  end
end
