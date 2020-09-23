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

  it 'can get travel time between coordinates' do
    VCR.use_cassette 'travel time between coordinates' do
      coordinates =     { :start=> "36.147506,-82.413996",
                    :destination=> "35.8536,-82.2401" }
      time = MapQuestService.find_travel_time(coordinates)
      expect(time).to eq({:formatted=>"01:36:38", :seconds=>5798})
    end
  end

  it 'can get travel time between more coordinates' do
    VCR.use_cassette 'travel time between more coordinates' do
      coordinates =     { :start=> "39.738453,104.984853",
                    :destination=> "40.015831, 105.27927" }
      time = MapQuestService.find_travel_time(coordinates)
      expect(time).to eq({:formatted=>"00:00:00", :seconds=>0})
    end
  end
end
