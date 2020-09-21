class MountainProjectService
  def self.find_routes coordinates
    response = conn.get '/data/get-routes-for-lat-lon' do |request|
      request.params[:lat] = coordinates[:latitude]
      request.params[:lon] = coordinates[:longitude]
    end
    routes = JSON.parse response.body, symbolize_names: true
    routes[:routes].take(3)
  end

  def self.conn
    url = ENV['MOUNTAIN_PROJECT_URL']
    @conn ||= Faraday.new url do |f|
      f.params[:key] = ENV['MOUNTAIN_PROJECT_KEY']
    end
  end
end
