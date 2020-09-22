class ClimbingRoutesFacade
  def self.build_facade(params)
    climbing_routes = new(params)
    {
      data: {
        id: nil,
        type: 'climbing route',
        attributes: {
          location: climbing_routes.location,
          forecast: {
            summary: climbing_routes.forecast[:summary],
            temperature: climbing_routes.forecast[:temperature]
          },
          routes: climbing_routes.routes.map(&climbing_route_details)
        }
      }
    }
  end

  def self.climbing_route_details
    proc do |route|
      {
        name: route[:name],
        type: route[:type],
        rating: route[:rating],
        location: route[:location],
        distance_to_route: route[:distance_to_route]
      }
    end
  end

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
    start_params = { latitude: forecast_facade.location[:latitude],
                     longitude: forecast_facade.location[:longitude] }

    climbing_routes = MountainProjectService.find_routes(start_params)
    climbing_routes.map do |route|

      destination_params = { latitude: route[:latitude],
                             longitude: route[:longitude] }

         distance_params = { start: start_params,
                             destination: destination_params }

      {
        name: route[:name],
        type: route[:type],
        rating: route[:rating],
        location: route[:location],
        distance_to_route: MapQuestService.find_distance_between(distance_params)
      }
    end
  end
end
