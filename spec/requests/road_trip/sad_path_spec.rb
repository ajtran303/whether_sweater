require 'rails_helper'

RSpec.describe 'Road Trip Endpoint Sad Paths' do
  it 'fails when no api key' do
    params = {
      'origin' => 'Denver,CO',
      'destination' => 'Pueblo,CO',
      'api_key' => ''
    }

    headers = {
      'CONTENT_TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }

    post '/api/v1/road_trip', headers: headers, params: params.to_json

    expect(response.media_type).to eq('application/json')
    expect(response.status).to eq(401)
    expect(response).to_not be_successful

    result = parse_body(response)

    expect(result).to have_key :errors
    expect(result).to_not have_key :data

    errors = ["API Key can't be blank"]
    expect(result[:errors]).to be_a Array
    expect(result[:errors]).to match_array errors
  end

  it 'fails when api key not found' do
    # no user or api key was created
    params = {
      'origin' => 'Denver,CO',
      'destination' => 'Pueblo,CO',
      'api_key' => 'boo'
    }

    headers = {
      'CONTENT_TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }

    post '/api/v1/road_trip', headers: headers, params: params.to_json

    expect(response.media_type).to eq('application/json')
    expect(response.status).to eq(401)
    expect(response).to_not be_successful

    result = parse_body(response)

    expect(result).to have_key :errors
    expect(result).to_not have_key :data

    errors = ["API Key not found"]
    expect(result[:errors]).to be_a Array
    expect(result[:errors]).to match_array errors
  end
end
