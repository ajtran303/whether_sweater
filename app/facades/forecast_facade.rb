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
    {city: city, state: state, country: country}
  end
end
