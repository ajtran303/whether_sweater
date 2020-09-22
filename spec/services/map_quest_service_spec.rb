require 'rails_helper'

RSpec.describe MapQuestService do
  it 'can locate' do
    VCR.use_cassette 'can locate' do
      location = MapQuestService.locate('denver,co')

      expect(location).to be_a Hash
      expect(location.keys.size).to eq 3
      expect(location[:info]).to be
      expect(location[:options]).to be
      expect(location[:results]).to be

      expect(location[:info][:statuscode]).to eq 0
    end
  end

  it 'can get distance between coordinates' do
    VCR.use_cassette 'can get distance between coordinates' do
      coordinates =     { :start=> {:latitude=>36.147506, :longitude=>-82.413996},
                    :destination=> {:latitude=>35.8536,   :longitude=>-82.2401} }
      distance = MapQuestService.find_distance_between(coordinates)
      expect(distance).to eq 61.615
    end
  end

  it 'can get distance between more coordinates' do
    VCR.use_cassette 'can get distance between more coordinates' do
      coordinates =     { :start=> {:latitude=>39.738453, :longitude=>-104.984853},
                    :destination=> {:latitude=>40.015831,   :longitude=>-105.27927} }
      distance = MapQuestService.find_distance_between(coordinates)
      expect(distance).to eq 31.045
    end
  end
end
