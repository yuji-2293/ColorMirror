require 'rails_helper'

RSpec.describe WeatherService do
  describe "#initialize" do
    it "有効な都市名が設定される" do
      service = WeatherService.new("Tokyo").fetch_weather
      data  =  service.parsed_response
      expect(data["name"]).to eq("東京都")
    end
    it "無効な都市名が設定されると東京都が返される" do
      service = WeatherService.new("123tokyo").fetch_weather
      data  =  service.parsed_response
      expect(data["name"]).to eq("東京都")
    end
  end
  describe "#fetch_weather" do
    it "HTTParty.getが正しいURLで呼ばれる" do
      service = WeatherService.new("Tokyo")
      expect(WeatherService).to receive(:get).with("/data/2.5/weather", anything)
      service.fetch_weather
    end
  end
end
