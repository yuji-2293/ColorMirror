class SelfLog < ApplicationRecord
  belongs_to :user
  belongs_to :color
  has_many :responses, dependent: :destroy
  has_one :weather_log, dependent: :destroy
end
