require 'rails_helper'

RSpec.describe 'Forecast Endpoint can respond to correct request type' do
  # GET /api/v1/forecast?location=denver,co
  # Content-Type: application/vnd.api+json
  # Accept: application/vnd.api+json

  it 'responds to application/vnd.api+json with a success' do
    forecast_params = {
      'location' => 'denver,co'
    }

    headers = {
      'CONTENT_TYPE' => 'application/vnd.api+json',
      'ACCEPT' => 'application/vnd.api+json'
    }

    get '/api/v1/forecast', headers: headers, params: forecast_params

    expect(response.media_type).to eq('application/vnd.api+json')
    expect(response.status).to eq(200)
    expect(response).to be_successful

    forecast = parse_body(response)

    expect(forecast).to_not have_key :errors
    expect(forecast).to have_key :data

    expect(forecast[:data].keys.size).to eq 3
    expect(forecast[:data]).to have_key :type
    expect(forecast[:data]).to have_key :id
    expect(forecast[:data]).to have_key :attributes
  end
end
