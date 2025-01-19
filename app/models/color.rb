class Color < ApplicationRecord
  has_many :self_logs
  has_many :users, through: :self_logs, dependent: :destroy

  validates :color_name, presence: true
end
