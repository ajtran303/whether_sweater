class ClimbingRoutesSerializer
  def self.to_json_api(climbing_params)
    {
      data: {
        id: nil,
        type: 'climbing route',
        attributes: {
          location: climbing_params[:location],
          forecast: {
            summary: climbing_params[:summary],
            temperature: climbing_params[:temperature]
          },
          routes: climbing_params[:routes]
        }
      }
    }
  end
end
