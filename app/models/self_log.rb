class SelfLog < ApplicationRecord
  belongs_to :user
  belongs_to :color
  has_one :response, dependent: :destroy
  has_one :weather_log, dependent: :destroy
end
