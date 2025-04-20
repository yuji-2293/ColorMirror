class Color < ApplicationRecord
  has_many :self_logs, dependent: :destroy
  has_many :responses, through: :self_logs, dependent: :destroy
  has_many :weather_logs, through: :self_logs, dependent: :destroy

  validates :color_name, presence: true
  # validates :mood, presence: true
  # validates :mood_level, presence: true
end
