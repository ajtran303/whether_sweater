class Api::V1::RoadTripController < Api::V1::AuthorizeController
  def create
    trip_params = {origin: params[:origin], destination: params[:destination]}
    trip = RoadTripFacade.build_facade trip_params
    render json: trip, status: 200
  end
end
