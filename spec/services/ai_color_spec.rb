require "rails_helper"

RSpec.describe AiColorService do
  describe "#generate_color" do
    it "有効な色名が生成される" do
      mood = "ワクワク"
      weather = build(:weather_log)
      suggested_colors = AiColorService.generate_color(mood, weather)
      expect(suggested_colors).to be_an (Array)
      expect(suggested_colors.size).to eq(4)
    end
  end
end
