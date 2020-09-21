class MapQuestService
  def self.locate(location_query)
    conn.get '/geocoding/v1/address' do |request|
      request.params[:location] = location_query
    end
  end

  def self.conn
    @conn ||= Faraday.new ENV['MAP_QUEST_URL'] do |f|
      f.params[:key] = ENV['MAP_QUEST_KEY']
    end
  end
end
