require 'rails_helper'

RSpec.describe 'Wrong Content Type Request to Forecast Endpoint' do
  # GET /api/v1/forecast?location=denver,co
  # Content-Type: application/json
  # Accept: application/json

  it 'responds to application/json with an error' do
    forecast_params = {
      'location' => 'denver,co'
    }

    headers = {
      'CONTENT_TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }

    get '/api/v1/forecast', headers: headers, params: forecast_params

    expect(response.media_type).to eq('application/vnd.api+json')
    expect(response.status).to eq(415)
    expect(response).to_not be_successful

    error = parse_body(response)

    expect(error).to_not have_key :data
    expect(error).to have_key :errors

    expect(error[:errors][0][:status]).to eq('415')
    expect(error[:errors][0][:source]).to eq({ pointer: '/api/v1/forecast' })
    expect(error[:errors][0][:title]).to eq('Unsupported Media Type')

    detail = 'This API conforms to the JSON API Spec. ' +
             'Requests must have the header ' +
             '`Content-Type: application/vnd.api+json`.'
    expect(error[:errors][0][:detail]).to eq(detail)
  end
end
