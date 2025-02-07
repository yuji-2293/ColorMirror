class WeatherLog < ApplicationRecord
  belongs_to :self_log

  validates :city, presence: true
end
