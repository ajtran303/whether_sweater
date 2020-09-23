require 'rails_helper'

RSpec.describe UserFacade do
  it 'build_facade' do
    user = create :user
    result = UserFacade.build_facade user
    expect(result).to be_a Hash
    expect(result).to_not have_key :errors
    expect(result).to have_key :data

    top_level = [:type, :id, :attributes]
    expect(result[:data].keys).to match_array top_level
    expect(result[:data][:type]).to eq 'users'
    expect(result[:data][:id]).to eq user.id
    expect(result[:data][:attributes]).to be_a Hash

    attributes = [:email, :api_key]
    expect(result[:data][:attributes].keys).to match_array attributes
    expect(result[:data][:attributes][:email]).to eq user.email
    expect(result[:data][:attributes][:api_key]).to eq user.api_key
  end
end
