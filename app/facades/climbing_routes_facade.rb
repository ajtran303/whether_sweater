class ClimbingRoutesFacade
  attr_reader :location

  def initialize(params)
    @location = params[:location]
  end

  def forecast_facade
    @forecast_facade ||= ForecastFacade.new location: location
  end

  def forecast
    summary = forecast_facade.current_weather[:condition]
    temperature = forecast_facade.current_weather[:temperature]
    {summary: summary, temperature: temperature}
  end

  def routes
    latitude = forecast_facade.location[:latitude]
    longitude = forecast_facade.location[:longitude]
    start_params = {latitude: latitude, longitude: longitude}

    climbing_routes = MountainProjectService.find_routes(start_params)
    climbing_routes.map do |route|
      destination_params = {latitude: route[:longitude], longitude: route[:latitude]}
      distance_params = {start: start_params, end: destination_params}
      {
        name: route[:name],
        type: route[:type],
        rating: route[:rating],
        location: route[:location]
        distance_to_route: MapQuestService.find_distance_between(distance_params)
      }
    end
  end
end
