class WeathersController < ApplicationController
  before_action :validate_city, only: %i[show]
require "httparty"
require "uri"

def index;end

def show
      city = params[:city] || "Tokyo"
      response = WeatherService.new(city).fetch_weather
      if response.success?
        weather_data = response.parsed_response
          data = {
          name: weather_data["name"],
          country: weather_data["sys"]["country"],
          temp_celsius: kelvin_to_celsius(weather_data["main"]["temp"]).round(1),
          temp_min_celsius: kelvin_to_celsius(weather_data["main"]["temp_min"]).round(1),
          temp_max_celsius: kelvin_to_celsius(weather_data["main"]["temp_max"]).round(1),
          pressure: weather_data["main"]["pressure"],
          weather_icon: weather_data["weather"][0]["icon"],
          description: weather_data["weather"][0]["description"]
          }
          render json: data, status: :ok
      else
        render json: { error: "天気情報が取得できませんでした" }, status: :not_found

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
