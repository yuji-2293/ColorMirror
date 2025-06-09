class WeatherLog < ApplicationRecord
  belongs_to :self_log

  validates :city, presence: true

  WEATHER_SCORE = {
  "01d" => 3,
  "02d" => 3,
  "03d" => 2,
  "04d" => 2,
  "09d" => 1,
  "10d" => 1,
  "11d" => 1,
  "13d" => 1,
  "50d" => 1,
  "01n" => 3,
  "02n" => 3,
  "03n" => 2,
  "04n" => 2,
  "09n" => 1,
  "10n" => 1,
  "11n" => 1,
  "13n" => 1,
  "50n" => 1
    }.freeze

  def weather_score
    WEATHER_SCORE[weather_icon] || 0
  end
end
