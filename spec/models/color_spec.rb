require 'rails_helper'

RSpec.describe Color, type: :model do
  subject(:color) { build(:color) }
describe "#mood_scoreが機能するか？" do
  {
    "ホッと" => 5,
    "ワクワク" => 4,
    "わからない" => 3,
    "モヤモヤ" => 2,
    "ムカムカ" => 1,
    nil => 0
  }.each do |mood_value, expected_score|
    it "moodが#{mood_value.inspect}のとき、返り値が#{expected_score}になること" do
    mood = Color.new(mood: mood_value)
    expect(mood.mood_score).to eq(expected_score)
    end
  end
end
    it { is_expected.to validate_presence_of(:color_name) }

    context "アソシエーション" do
      it { is_expected.to have_many(:self_logs) }
      it { is_expected.to have_many(:weather_logs) }
      it { is_expected.to have_many(:responses) }
    end
    context "Colorバリデーションの機能テスト" do
      it "設定したバリデーションが機能しているか" do
        color = build(:color)
        expect(color).to be_valid
        expect(color.errors).to be_empty
      end
      it "DBにユーザーを作成したとき、バリデーションが機能しているか" do
        color = create(:color)
        expect(color).to be_valid
        expect(color.errors).to be_empty
      end
    end
end
