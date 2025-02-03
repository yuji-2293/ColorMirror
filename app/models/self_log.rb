class SelfLog < ApplicationRecord
  belongs_to :user
  belongs_to :color
  has_many :responses, dependent: :destroy
  has_one :weather_log, dependent: :destroy

  accepts_nested_attributes_for :weather_log
end
