require 'rails_helper'

RSpec.describe WeatherLog, type: :model do
  subject(:weather_log) { build(:weather_log) }

  it { is_expected.to validate_presence_of(:city) }

  describe "#weather_scoreが機能するか？" do
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
}.each do |weather_value, expected_score|
  it "weather_iconが#{weather_value.inspect}の時、返り値が#{expected_score}になること" do
    weather_icon = WeatherLog.new(weather_icon: weather_value)
    expect(weather_icon.weather_score).to eq(expected_score)
    end
  end
end

  context "アソシエーション" do
    it { is_expected.to belong_to(:self_log) }
  end

  context "weather_logのバリデーション機能テスト" do
    it "設定したバリデーションが機能しているか" do
      weather_log = build(:weather_log)
      expect(weather_log).to be_valid
      expect(weather_log.errors).to be_empty
    end
  end
end
