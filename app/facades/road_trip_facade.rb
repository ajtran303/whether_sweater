class RoadTripFacade
  def self.build_facade params
    trip = new params
    { data: {
        type: 'road_trip',
        id: nil,
        attributes: {
          arrival_forecast: trip.arrival_forecast,
          origin: params[:origin],
          destination: params[:destination],
          travel_time: trip.travel_time
        }
      }
    }
  end

  def initialize(params)
    @origin = params[:origin]
    @destination = params[:destination]
  end

  def arrival_forecast
    hour = (travel_time[:seconds] / 60 / 60.0).ceil - 1
    if hour > 7
      { temperature: 'Forecasts not available', condition: 'for 8+ hour trips' }
    elsif travel_time[:seconds].zero?
      { temperature: 'Forecasts not available', condition: 'for short trips' }
    else
      {
        temperature: destination_forecast.eight_hour[hour][:temperature].to_s,
        condition: destination_forecast.eight_hour[hour][:condition]
      }
    end
  end

  def travel_time
    coordinates = {start: origin_coordinates, destination: destination_coordinates}
    @travel_time ||= MapQuestService.find_travel_time(coordinates)
  end

  private

  def origin_coordinates
    latitude = origin_forecast.location[:latitude]
    longitude = origin_forecast.location[:longitude]
    "#{latitude},#{longitude}"
  end

  def destination_coordinates
    latitude = destination_forecast.location[:latitude]
    longitude = destination_forecast.location[:longitude]
    "#{latitude},#{longitude}"
  end

  def origin_forecast
    @origin_forecast ||= ForecastFacade.new location: @origin
  end

  def destination_forecast
    @destination_forecast ||= ForecastFacade.new location: @destination
  end
end
