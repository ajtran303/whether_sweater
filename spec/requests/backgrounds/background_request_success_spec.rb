require 'rails_helper'

RSpec.describe 'Background Endpoint can respond to correct request type' do
  it 'responds to application/json with a success' do
    VCR.use_cassette 'success' do
      params = {
        'location' => 'denver,co'
      }

      headers = {
        'CONTENT_TYPE' => 'application/json',
        'ACCEPT' => 'application/json'
      }

      get '/api/v1/backgrounds', headers: headers, params: params

      expect(response.media_type).to eq('application/json')
      expect(response.status).to eq(200)
      expect(response).to be_successful

      background = parse_body(response)

      expect(background).to_not have_key :errors
      expect(background).to have_key :data

      expect(background[:data]).to have_key :type
      expect(background[:data]).to have_key :id
      expect(background[:data]).to have_key :attributes
      expect(background[:data].keys.size).to eq 3

      expect(background[:data][:type]).to eq 'image'
      expect(background[:data][:id]).to be_nil
      expect(background[:data][:attributes]).to be_a Hash

      attributes = [:keyword_search, :image_url, :credit]
      expect(background[:data][:attributes].keys).to match_array attributes

      expect(background[:data][:attributes][:keyword_search]).to be_a String
      expect(background[:data][:attributes][:image_url]).to be_a String
      expect(background[:data][:attributes][:credit]).to be_a Hash

      credits = [:source, :author, :logo]
      expect(background[:data][:attributes][:credit].keys).to match_array credits
      expect(background[:data][:attributes][:credit][:source]).to be_a String
      expect(background[:data][:attributes][:credit][:author]).to be_a String
      expect(background[:data][:attributes][:credit][:logo]).to be_a String
    end
  end
end
