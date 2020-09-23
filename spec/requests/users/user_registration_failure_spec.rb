require 'rails_helper'

RSpec.describe 'User Registration Endpoint' do
  it 'does not let a user registers with taken email' do
    user = create :user
    params = {
      'email' => user.email,
      'password' => 'password',
      'password_confirmation' => 'password'
    }

    headers = {
      'CONTENT_TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }

    expect do
      post '/api/v1/users', headers: headers, params: params.to_json
    end.to change(User, :count).by(0)

    expect(response.media_type).to eq('application/json')
    expect(response.status).to eq(400)
    expect(response).to_not be_successful

    result = parse_body(response)
    expect(result).to have_key :errors
    expect(result).to_not have_key :data

    expect(result[:errors]).to be_a Array
    expect(result[:errors].size).to eq 1
    expect(result[:errors][0]).to eq 'Email has already been taken'
  end
end
