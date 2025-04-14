module WeatherHelper
  def pressure_status(weather_pressure)
    return "気圧データなし" if weather_pressure.nil?
    case weather_pressure
    when 1000..1010 then "低気圧が近づいているので、体調管理に注意してください。"
    when 1011..1015 then "気圧は安定しています。過ごしやすい一日になりそうです。"
    when 1016..Float::INFINITY then "高気圧の影響で、空気が澄んでいます！"
    else "気圧が不安定です。無理せずリラックスしてください。"
    end
  end

  WEATHER_MAPPING = {
    "01d" => "/images/weather/sunny.webp",
    "02d" => "/images/weather/party_cloudy.webp",
    "03d" => "/images/weather/cloudy.webp",
    "04d" => "/images/weather/overcast.webp",
    "09d" => "/images/weather/rain.webp",
    "10d" => "/images/weather/showers.webp",
    "11d" => "/images/weather/thunderstorm.webp",
    "13d" => "/images/weather/snow.webp",
    "50d" => "/images/weather/mist.webp",
    # 夜のアイコン
    "01n" => "/images/weather/sunny.webp",
    "02n" => "/images/weather/party_cloudy.webp",
    "03n" => "/images/weather/cloudy.webp",
    "04n" => "/images/weather/overcast.webp",
    "09n" => "/images/weather/rain.webp",
    "10n" => "/images/weather/showers.webp",
    "11n" => "/images/weather/thunderstorm.webp",
    "13n" => "/images/weather/snow.webp",
    "50n" => "/images/weather/mist.webp"
  }.freeze

  def self.weather_image(icon_code)
    WEATHER_MAPPING[icon_code] || "images/weather/sunny.webp"
  end
end
