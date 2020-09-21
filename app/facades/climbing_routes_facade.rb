class ClimbingRoutesFacade
  attr_reader :location

  def initialize(params)
    @location = params[:location]
  end

  def forecast
    forecast = ForecastFacade.new location: location
    summary = forecast.current_weather[:condition]
    temperature = forecast.current_weather[:temperature]
    {summary: summary, temperature: temperature}
  end
end
