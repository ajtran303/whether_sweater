class ForecastFacade
  def initialize params
    @location = params[:location]
  end

  def location
    response = MapQuestService.locate(@location)
    geocoding = JSON.parse(response.body, symbolize_names: true)

    city = geocoding[:results][0][:locations][0][:adminArea5]
    state = geocoding[:results][0][:locations][0][:adminArea3]
    country = geocoding[:results][0][:locations][0][:adminArea1]
    latitude = geocoding[:results][0][:locations][0][:latLng][:lat]
    longitude = geocoding[:results][0][:locations][0][:latLng][:lng]

    { city: city,
      state: state,
      country: country,
      latitude: latitude,
      longitude: longitude }
  end
end
