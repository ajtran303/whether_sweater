class ForecastFacade
  def initialize params
    @location_params = params[:location]
  end

  def location
    @location ||= {
      city: geocoding[:results][0][:locations][0][:adminArea5],
      state: geocoding[:results][0][:locations][0][:adminArea3],
      country: geocoding[:results][0][:locations][0][:adminArea1],
      latitude: geocoding[:results][0][:locations][0][:latLng][:lat],
      longitude: geocoding[:results][0][:locations][0][:latLng][:lng]
    }
  end

  def current_weather
  end

  def geocoding
    response = MapQuestService.locate @location_params
    geocoding ||= JSON.parse response.body, symbolize_names: true
  end
end
