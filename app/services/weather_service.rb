class WeatherService
  include HTTParty

  base_uri "api.openweathermap.org"

  def initialize(city)
    api_key = ENV["OPNEWEATHERMAP_API_KEY"]
    @options = { query: { q: "#{city},jp", appid: api_key, lang: "ja" } }
  end

  def fetch_weather
    self.class.get("/data/2.5/weather", @options)
  end
end
