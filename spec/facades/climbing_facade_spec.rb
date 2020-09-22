require 'rails_helper'

RSpec.describe ClimbingRoutesFacade do
  describe 'class methods' do
    it 'build_facade' do
      facade = ClimbingRoutesFacade.build_facade location: 'denver,co'

      expect(facade).to be_a Hash
      expect(facade.keys.size).to eq 1
      expect(facade.keys).to match_array [:data]

      expect(facade[:data]).to be_a Hash
      expect(facade[:data].keys.size).to eq 3
      expect(facade[:data].keys).to match_array [:id, :type, :attributes]

      expect(facade[:data][:id]).to be_nil

      expect(facade[:data][:attributes]).to be_a Hash
      expect(facade[:data][:attributes].keys.size).to eq 3
      expect(facade[:data][:attributes].keys).to match_array [:location, :forecast, :routes]

      expect(facade[:data][:attributes][:forecast]).to be_a Hash
      expect(facade[:data][:attributes][:forecast].keys.size).to eq 2
      expect(facade[:data][:attributes][:forecast].keys).to match_array [:summary, :temperature]

      expect(facade[:data][:attributes][:routes]).to be_a Array
      expect(facade[:data][:attributes][:routes].size).to eq 3

      route = facade[:data][:attributes][:routes].first

      expect(route).to be_a Hash
      expect(route.keys).to match_array [:name, :type, :location, :rating, :distance_to_route]
    end
  end
  describe 'instance methods' do
    before :each do
      @facade = ClimbingRoutesFacade.new location: 'denver,co'
    end

    it 'exists' do
      expect(@facade).to be_a ClimbingRoutesFacade
    end

    it 'location' do
      expect(@facade.location).to eq 'denver,co'
    end

    it 'forecast' do
      expect(@facade.forecast).to be_a Hash
      expect(@facade.forecast.keys.size).to eq 2
      expect(@facade.forecast.keys).to match_array [:summary, :temperature]
    end

    it 'routes' do
      expect(@facade.routes).to be_a Array
      expect(@facade.routes.size).to eq 3
      expect(@facade.routes.first).to be_a Hash
      expect(@facade.routes.first.keys).to match_array [:name, :type, :location, :rating, :distance_to_route]
    end
  end
end
