class Color < ApplicationRecord
  has_many :self_logs, dependent: :destroy
  has_many :responses, through: :self_logs, dependent: :destroy
  has_many :weather_logs, through: :self_logs, dependent: :destroy

  validates :color_name, presence: true
  # validates :mood, presence: true
  # validates :mood_level, presence: true

  def self.mood_score_map
    {
      "ホッと" => 5,
      "ワクワク" => 4,
      "わからない" => 3,
      "モヤモヤ" => 2,
      "ムカムカ" => 1
  }
  end

  def mood_score
    self.class.mood_score_map[mood] || 0
  end
end
