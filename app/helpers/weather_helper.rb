module WeatherHelper
  def pressure_status(weather_pressure)
    return "気圧データなし" if weather_pressure.nil?

    case weather_pressure
    when 1016..Float::INFINITY then "気圧が高めです!!"
    when 1013..1015 then "気圧はほぼ平均的です"
    else "気圧が低めです！（体調の変化に注意してください！！）"
    end
  end
end
