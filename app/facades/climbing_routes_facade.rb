class ClimbingRoutesFacade
  attr_reader :location

  def initialize(location)
    @location = location
  end

  def forecast
    response = ForecastFacade.new location: location
    # summary =
    # temperature =
    # ForecastSummarizer.new(summary, temperature)
  end
end
