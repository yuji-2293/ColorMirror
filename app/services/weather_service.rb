class WeatherService
  include HTTParty

  base_uri "api.openweathermap.org"

  attr_reader :city
  DEFAULT_CITY = "Tokyo"

  def initialize(city)
    @city = valid_city?(city) ? city : DEFAULT_CITY
    api_key = ENV["OPENWEATHERMAP_API_KEY"]
    @options = { query: { q: "#{@city}", appid: api_key, lang: "ja" } }
  end

  def fetch_weather
    self.class.get("/data/2.5/weather", @options)
  end

  private

  def valid_city?(city)
    return false if city.blank?
    return false if city.match?(/[^a-zA-Z\s-]/)
    true
  end
end
