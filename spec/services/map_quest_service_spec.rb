require 'rails_helper'

RSpec.describe MapQuestService do
  it 'can locate' do
    json = MapQuestService.locate('denver,co')
    location = JSON.parse json.body, symbolize_names: true

    expect(location).to be_a Hash
    expect(location).to have_keys :info
    expect(location).to have_keys :options
    expect(location).to have_keys :results

    expect(location[:info][:statuscode]).to eq 0
  end

  it 'can get distance between coordinates' do
    coordinates =     { :start=> {:latitude=>36.147506, :longitude=>-82.413996},
                  :destination=> {:latitude=>35.8536,   :longitude=>-82.2401} }
    distance = MapQuestService.find_distance_between(coordinates)
    expect(distance).to eq 61.615
  end

end
