class ClimbingRoutesSerializer
  def self.to_json_api(climbing_routes)
    {
      data: {
        id: nil,
        type: 'climbing route',
        attributes: {
          location: nil,
          forecast: {
            summary: nil,
            temperature: nil
          },
          routes: [
            {
              name: nil,
              type: nil,
              rating: nil,
              location: nil,
              distance_to_route: nil
            }
          ]
        }
      }
    }
  end
end
