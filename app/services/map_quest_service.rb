class MapQuestService < ConnectionService
  def self.locate(location_query)
    parse_body geocoding.call location_query
  end

  def self.find_distance_between(coordinates)
    start_param = "#{coordinates[:start][:latitude]},#{coordinates[:start][:longitude]}"
    destination_param = "#{coordinates[:destination][:latitude]},#{coordinates[:destination][:longitude]}"
    directions_params = { from: start_param, to: destination_param }
    travel_route = parse_body directions.call directions_params
    travel_route[:route][:distance]
  end

  private

  def self.directions
    proc do |directions|
      travel_route = conn.get '/directions/v2/route' do |request|
        request.params[:from] = directions[:from]
        request.params[:to] = directions[:to]
      end
    end
  end

  def self.geocoding
    proc do |location|
      conn.get '/geocoding/v1/address' do |request|
        request.params[:location] = location
      end
    end
  end

  def self.conn
    @conn ||= Faraday.new ENV['MAP_QUEST_URL'] do |f|
      f.params[:key] = ENV['MAP_QUEST_KEY']
    end
  end
end
