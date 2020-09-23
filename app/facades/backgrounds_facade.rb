class BackgroundsFacade
  def self.build_facade params
    background = new location: params[:location]
    {
      data: {
        type: 'image',
        id: nil,
        attributes: {
          keyword_search: background.keyword_search,
          image_url: background.image_url,
          credit: {
            source: background.source,
            author: background.author,
            logo: background.logo
          }
        }
      }
    }
  end


  def initialize params
    @location = params[:location]
  end

  def location
    forecast.location[:city]
  end

  def weather
    forecast.current_weather[:condition]
  end

  def keyword_search
    @location
  end

  def image_url
    image_search[:largeImageURL]
  end

  def source
    image_search[:pageURL]
  end

  def author
    image_search[:user]
  end

  def logo
    'https://pixabay.com/static/img/logo_square.png'
  end

  private

  def image_search
    image_search_params = {location: location, weather: weather}
    @image_search ||= PixabayService.find_photograph image_search_params
  end

  def forecast
    @forecast ||= ForecastFacade.new location: @location
  end
end
