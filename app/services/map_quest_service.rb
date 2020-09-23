class MapQuestService < ConnectionService
  def self.locate(location_query)
    parse_body geocoding.call location_query
  end

  def self.find_travel_time(coordinates)
    directions_params = { from: coordinates[:start], to: coordinates[:destination] }
    travel_route = parse_body directions.call directions_params
    { formatted: travel_route[:route][:formattedTime],
      seconds: travel_route[:route][:time] }
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
