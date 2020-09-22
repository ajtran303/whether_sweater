require 'rails_helper'

RSpec.describe ForecastFacade do
  describe 'class methods' do
    it 'build_facade', :vcr do
      facade = ForecastFacade.build_facade location: 'denver,co'

      expect(facade).to be_a Hash
      expect(facade.keys.size).to eq 1
      expect(facade.keys).to match_array [:data]

      expect(facade[:data]).to be_a Hash
      expect(facade[:data].keys.size).to eq 3
      expect(facade[:data].keys).to match_array [:id, :type, :attributes]

      expect(facade[:data][:id]).to be_nil

      expect(facade[:data][:attributes]).to be_a Hash
      expect(facade[:data][:attributes].keys.size).to eq 4
      attributes = [:date_time, :location, :current_weather, :forecast]
      expect(facade[:data][:attributes].keys).to match_array attributes

      expect(facade[:data][:attributes][:date_time]).to be_a String
      expect(facade[:data][:attributes][:location]).to be_a Hash
      expect(facade[:data][:attributes][:location].keys.size).to eq 5
      location = [:city, :state, :country, :latitude, :longitude]
      expect(facade[:data][:attributes][:location].keys).to match_array location

      expect(facade[:data][:attributes][:current_weather]).to be_a Hash
      expect(facade[:data][:attributes][:current_weather].keys.size).to eq 10
      current_weather = [:condition, :temperature, :high, :low, :feels_like, :humidity, :visibility, :uv_index, :sunrise, :sunset]
      expect(facade[:data][:attributes][:current_weather].keys).to match_array current_weather

      expect(facade[:data][:attributes][:forecast]).to be_a Hash
      expect(facade[:data][:attributes][:forecast].keys.size).to eq 2
      forecast = [:five_day, :eight_hour]
      expect(facade[:data][:attributes][:forecast].keys).to match_array forecast
    end

  end
  it 'instance methods', :vcr do
    forecast = ForecastFacade.new location: 'denver,co'
    # it 'exists' do
    expect(forecast).to be_a ForecastFacade

    # it 'date_time' do
    expect(forecast.date_time).to be_a String

    # it 'location' do
    expect(forecast.location).to be_a Hash
    expect(forecast.location.keys.size).to eq 5
    location = [:city, :state, :country, :latitude, :longitude]
    expect(forecast.location.keys).to match_array location

    # it 'current_weather' do
    expect(forecast.current_weather).to be_a Hash
    expect(forecast.current_weather.keys.size).to eq 10
    current_weather = [:condition, :temperature, :high, :low, :feels_like, :humidity, :visibility, :uv_index, :sunrise, :sunset]
    expect(forecast.current_weather.keys).to match_array current_weather

    # it 'eight_hour' do
    expect(forecast.eight_hour).to be_a Array
    expect(forecast.eight_hour.size).to eq 8
    hour = forecast.eight_hour.first
    expect(hour).to be_a Hash
    expect(hour.keys.size).to eq 3
    expect(hour.keys).to match_array [:hour, :condition, :temperature]

    # it 'five_day' do
    expect(forecast.five_day).to be_a Array
    expect(forecast.five_day.size).to eq 5
    day = forecast.five_day.first
    expect(day).to be_a Hash
    expect(day.keys.size).to eq 5
    expect(day.keys).to match_array [:day_of_week, :condition, :precipitation, :high, :low]
  end
end
