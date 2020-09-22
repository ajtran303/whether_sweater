class MapQuestService
  def self.locate(location_query)
    location = conn.get '/geocoding/v1/address' do |request|
      request.params[:location] = location_query
    end
    JSON.parse location.body, symbolize_names: true
  end

  def self.find_distance_between(coordinates)
    start_param = "#{coordinates[:start][:latitude]},#{coordinates[:start][:longitude]}"
    destination_param = "#{coordinates[:destination][:latitude]},#{coordinates[:destination][:longitude]}"
    response = conn.get '/directions/v2/route' do |request|
      request.params[:from] = start_param
      request.params[:to] = destination_param
    end
    route = JSON.parse response.body, symbolize_names: true
    route[:route][:distance]
  end

  def self.conn
    @conn ||= Faraday.new ENV['MAP_QUEST_URL'] do |f|
      f.params[:key] = ENV['MAP_QUEST_KEY']
    end
  end
end
