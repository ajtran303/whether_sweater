require 'rails_helper'

RSpec.describe 'Log in Endpoint Sad Path' do
  it 'cannot log in if all blank' do
    params = {
      'email' => '',
      'password' => ''
    }

    headers = {
      'CONTENT_TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }

    post '/api/v1/sessions', headers: headers, params: params.to_json

    expect(response.media_type).to eq('application/json')
    expect(response.status).to eq(401)
    expect(response).to_not be_successful

    result = parse_body(response)

    expect(result).to have_key :errors
    expect(result).to_not have_key :data

    expect(result[:errors]).to be_a Array
    errors = ["Email can't be blank", "Password can't be blank"]
    expect(result[:errors]).to match_array errors
  end

  it 'cannot log in if email blank' do
    params = {
      'email' => '',
      'password' => 'doo'
    }

    headers = {
      'CONTENT_TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }

    post '/api/v1/sessions', headers: headers, params: params.to_json

    expect(response.media_type).to eq('application/json')
    expect(response.status).to eq(401)
    expect(response).to_not be_successful

    result = parse_body(response)

    expect(result).to have_key :errors
    expect(result).to_not have_key :data

    expect(result[:errors]).to be_a Array
    errors = ["Email can't be blank"]
    expect(result[:errors]).to match_array errors
  end

  it 'cannot log in if password blank' do
    user = create :user
    params = {
      'email' => user.email,
      'password' => ''
    }

    headers = {
      'CONTENT_TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }

    post '/api/v1/sessions', headers: headers, params: params.to_json

    expect(response.media_type).to eq('application/json')
    expect(response.status).to eq(401)
    expect(response).to_not be_successful

    result = parse_body(response)

    expect(result).to have_key :errors
    expect(result).to_not have_key :data

    expect(result[:errors]).to be_a Array
    errors = ["Password can't be blank"]
    expect(result[:errors]).to match_array errors
  end

  it 'cannot log in if email not registered' do
    # no users are created in the test
    params = {
      'email' => 'a@me.com',
      'password' => 'doo'
    }

    headers = {
      'CONTENT_TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }

    post '/api/v1/sessions', headers: headers, params: params.to_json

    expect(response.media_type).to eq('application/json')
    expect(response.status).to eq(401)
    expect(response).to_not be_successful

    result = parse_body(response)

    expect(result).to have_key :errors
    expect(result).to_not have_key :data

    expect(result[:errors]).to be_a Array
    errors = ['No account registered with that email']
    expect(result[:errors]).to match_array errors
  end

  it 'cannot log in with wrong password' do
    user = create :user
    params = {
      'email' => user.email,
      'password' => 'doo'
    }

    headers = {
      'CONTENT_TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }

    post '/api/v1/sessions', headers: headers, params: params.to_json

    expect(response.media_type).to eq('application/json')
    expect(response.status).to eq(401)
    expect(response).to_not be_successful

    result = parse_body(response)

    expect(result).to have_key :errors
    expect(result).to_not have_key :data

    expect(result[:errors]).to be_a Array
    errors = ['Wrong password']
    expect(result[:errors]).to match_array errors
  end
end
