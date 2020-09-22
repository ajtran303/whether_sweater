class ClimbingRoutesSerializer
  def self.to_json_api(climbing_routes)
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
end
