class WeathersController < ApplicationController
  before_action :validate_city, only: %i[show]
require "httparty"
require "uri"

def index;end

def show
    response = WeatherService.new(params[:city]).fetch_weather
    if response.success?
      weather_data = response.parsed_response
      @weather = {
        name: weather_data["name"],
        temp_celsius: kelvin_to_celsius(weather_data["main"]["temp"]).round(1),
        temp_min_celsius: kelvin_to_celsius(weather_data["main"]["temp_min"]).round(1),
        temp_max_celsius: kelvin_to_celsius(weather_data["main"]["temp_max"]).round(1),
        pressure: weather_data["main"]["pressure"],
        description: weather_data["weather"][0]["description"]
      }
      @pressure_status = if @weather[:pressure] > 1013
                          "気圧が高まっています"
      elsif @weather = 1013
                          "平均的な気圧です"
      else
                            "気圧が低下しています"
      end
    else
      redirect_to weather_path, alert: "天気情報の取得に失敗しました。"
    end
end

private

  def validate_city
    redirect_to weather_path, alert: "都市名を入力してください。" if params[:city].blank?
  end

  def kelvin_to_celsius(kelvin)
    kelvin - 273.15
  end
end
