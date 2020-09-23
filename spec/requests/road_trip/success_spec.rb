require 'rails_helper'

RSpec.describe 'Road Trip Endpoint' do
  it 'is successful' do
    api_key = create(:user).api_key
    params = {
      'origin' => 'Denver,CO',
      'destination' => 'Pueblo,CO',
      'api_key' => api_key
    }

    headers = {
      'CONTENT_TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }

    post '/api/v1/road_trip', headers: headers, params: params.to_json

    expect(response.media_type).to eq('application/json')
    expect(response.status).to eq(200)
    expect(response).to be_successful

    result = parse_body(response)

    expect(result).to_not have_key :errors
    expect(result).to have_key :data

    top_level = [:type, :id, :attributes]
    expect(result[:data].keys).to match_array top_level
    expect(result[:data][:type]).to eq 'road_trip'
    expect(result[:data][:id]).to be_nil
    expect(result[:data][:attributes]).to be_a Hash

    attributes = result[:data][:attributes]
    attribute_keys = [:origin, :destination, :travel_time, :arrival_forecast]
    expect(attributes.keys).to match_array attribute_keys
    expect(attributes[:origin]).to be_a String
    expect(attributes[:destination]).to be_a String
    expect(attributes[:travel_time]).to be_a Hash

    travel_time = attributes[:travel_time]
    travel_time_keys = [:formatted, :seconds]
    expect(travel_time.keys).to match_array travel_time_keys
    expect(travel_time[:formatted]).to be_a String
    expect(travel_time[:seconds]).to be_a Numeric

    expect(attributes[:arrival_forecast]).to be_a Hash
    arrival_forecast = attributes[:arrival_forecast]
    arrival_forecast_keys = [:temperature, :condition]
    expect(arrival_forecast).to match_array arrival_forecast
    expect(arrival_forecast[:temperature]).to be_a String
    expect(arrival_forecast[:condition]).to be_a String
  end
end
