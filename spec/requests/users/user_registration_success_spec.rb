require 'rails_helper'

RSpec.describe 'User Registration Endpoint' do
  it 'lets a user registers' do
    params = {
      'email' => 'whatever@example.com',
      'password' => 'password',
      'password_confirmation' => 'password'
    }

    headers = {
      'CONTENT_TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }

    post '/api/v1/users', headers: headers, params: params.to_json

    expect(response.media_type).to eq('application/json')
    expect(response.status).to eq(200)
    expect(response).to be_successful

    result = parse_body(response)

    expect(result).to_not have_key :errors
    expect(result).to have_key :data

    top_level = [:type, :id, :attributes]
    expect(result[:data].keys).to match_array top_level
    expect(result[:data][:type]).to eq 'user'
    expect(result[:data][:id]).to be_nil
    expect(result[:data][:attributes]).to be_a Hash

    attributes = [:email, :api_key]
    expect(result[:data][:attributes].keys).to match_array attributes
    expect(result[:data][:attributes][:email]).to be_a String
    expect(result[:data][:attributes][:api_key]).to be_a String
  end
end
