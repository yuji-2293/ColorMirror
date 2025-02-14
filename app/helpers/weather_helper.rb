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
end
