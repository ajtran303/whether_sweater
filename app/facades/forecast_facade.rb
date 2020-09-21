class ForecastFacade
  def initialize params
    @location = params[:location]
  end

  def location
    response = MapQuestService.locate(@location)
    geocoding = JSON.parse(response.body, symbolize_names: true)
    city = geocoding[:results][1][:locations][:adminArea5]
    state = geocoding[:results][1][:locations][:adminArea3]
    country = geocoding[:results][1][:locations][:adminArea1]
    {city: city, state: state, country: country}
  end
end
