require 'rails_helper'

RSpec.describe 'GET /climbing_routes' do
  it 'responds with a success' do
    route_params = {
      'location' => 'erwin,tn'
    }

    headers = {
      'CONTENT_TYPE' => 'application/vnd.api+json',
      'ACCEPT' => 'application/vnd.api+json'
    }

    get '/api/v1/climbing_routes', headers: headers, params: route_params
    expect(response.media_type).to eq('application/vnd.api+json')
    expect(response.status).to eq(200)
    expect(response).to be_successful

    climbing_route = parse_body(response)

    expect(climbing_route[:data]).to have_key :id
    expect(climbing_route[:data]).to have_key :type
    expect(climbing_route[:data]).to have_key :attributes
    expect(climbing_route[:data].keys.size).to eq 3

    expect(climbing_route[:data][:id]).to be_nil
    expect(climbing_route[:data][:type]).to eq 'climbing route'
    expect(climbing_route[:data][:attributes]).to be_a Hash

    expect(climbing_route[:data][:attributes]).to have_key :location
    expect(climbing_route[:data][:attributes]).to have_key :forecast
    expect(climbing_route[:data][:attributes]).to have_key :routes
    expect(climbing_route[:data][:attributes].keys.size).to eq 3

    expect(climbing_route[:data][:attributes][:forecast]).to have_key :summary
    expect(climbing_route[:data][:attributes][:forecast]).to have_key :temperature
    expect(climbing_route[:data][:attributes][:forecast].keys.size).to eq 2

    expect(climbing_route[:data][:attributes][:routes]).to be_a Array
    expect(climbing_route[:data][:attributes][:routes].first).to be_a Hash

    expect(climbing_route[:data][:attributes][:routes].first).to have_key :name
    expect(climbing_route[:data][:attributes][:routes].first).to have_key :type
    expect(climbing_route[:data][:attributes][:routes].first).to have_key :rating
    expect(climbing_route[:data][:attributes][:routes].first).to have_key :location
    expect(climbing_route[:data][:attributes][:routes].first).to have_key :distance_to_route
    expect(climbing_route[:data][:attributes][:routes].first.keys.size).to eq 5
  end
end
