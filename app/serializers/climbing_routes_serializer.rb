class ClimbingRoutesSerializer
  def self.to_json_api(climbing_routes)
    {
      data: {
        id: nil,
        type: 'climbing route',
        attributes: {
          location: climbing_routes.location,
          forecast: {
            summary: climbing_routes.forecast.summary,
            temperature: climbing_routes.forecast.temperature
          },
          routes: climbing_routes.routes.map(&climbing_route_details)
        }
      }
    }
  end

  def climbing_route_details
    proc do |route|
      {
        name: route.name,
        type: route.type,
        rating: route.rating,
        location: route.location,
        distance_to_route: route.distance_to_route
      }
    end
  end
end
