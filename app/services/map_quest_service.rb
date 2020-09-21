class MapQuestService < ConnectionService
  def self.locate location_query
    geocoding = conn.get '/geocoding/v1/address' do |request|
      request.params[:location] = location_query
    end
    parse_body geocoding
  end

  def self.find_distance_between coordinates
    start_param = "#{coordinates[:start][:latitude]},#{coordinates[:start][:longitude]}"
    destination_param = "#{coordinates[:destination][:latitude]},#{coordinates[:destination][:longitude]}"
    directions = conn.get '/directions/v2/route' do |request|
      request.params[:from] = start_param
      request.params[:to] = destination_param
    end
    parse_body directions [:route][:distance]
  end

  private

  def self.conn
    @conn ||= Faraday.new ENV['MAP_QUEST_URL'] do |f|
      f.params[:key] = ENV['MAP_QUEST_KEY']
    end
  end
end
