require 'rails_helper'

RSpec.describe BackgroundsFacade do
  it 'class methods' do
    background = BackgroundsFacade.build_facade location: 'denver,co'

    top_level = [:type, :id, :attributes]
    expect(background[:data].keys).to match_array top_level

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
  end


  it 'instance methods' do
    # it 'exists' do

    background = BackgroundsFacade.new location: 'denver,co'
    expect(background).to be_a BackgroundsFacade
    expect(background.location).to be_a String
    expect(background.weather).to be_a String
  end
end
