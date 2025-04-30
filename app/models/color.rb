class Color < ApplicationRecord
  has_many :self_logs, dependent: :destroy
  has_many :responses, through: :self_logs, dependent: :destroy
  has_many :weather_logs, through: :self_logs, dependent: :destroy

  validates :color_name, presence: true

    # 感情ごとのスコアマッピング
    MOOD_SCORE = {
      "ホッと" => 5,
      "ワクワク" => 4,
      "わからない" => 3,
      "モヤモヤ" => 2,
      "ムカムカ" => 1
    }.freeze

  def mood_score
    MOOD_SCORE[mood] || 0
  end
end
