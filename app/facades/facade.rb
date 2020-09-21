class Facade
  def parse_body json
    JSON.parse json.body, symbolize_names: true
  end
end
