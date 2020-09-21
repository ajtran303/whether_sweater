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
    route_params = {latitude: latitude, longitude: longitude}
    climbing_routes = MountainProjectService.find_routes(route_params)
    climbing_routes.take(3).map do |route|
      {
        # name: name,
        # type: type,
        # rating: rating,
        # location: location,
        # distance_to_route: distance_to_route
      }
    end
  end
end
