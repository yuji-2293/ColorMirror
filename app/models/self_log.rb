class SelfLog < ApplicationRecord
  belongs_to :user
  belongs_to :color
  has_many :responses
  has_many :Whether_logs
end
