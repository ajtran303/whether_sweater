require 'rails_helper'

RSpec.describe MountainProjectService do
  it 'can find routes' do
    coordinates = {:latitude=>40.015831, :longitude=>-105.27927}
    routes = MountainProjectService.find_routes coordinates

    expect(routes).to be_a Array
    expect(routes.size).to eq 3

    route_keys = [ :id,
                   :name,
                   :type,
                   :rating,
                   :stars,
                   :starVotes,
                   :pitches,
                   :location,
                   :url,
                   :imgSqSmall,
                   :imgSmall,
                   :imgSmallMed,
                   :imgMedium,
                   :longitude,
                   :latitude ]

    expect(routes.first.keys).to match_array route_keys
  end
end
