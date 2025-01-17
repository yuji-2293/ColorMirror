class Color < ApplicationRecord
  has_many :self_logs
  has_many :responses, through: :self_logs, dependent: :destroy
  #親モデルが子モデルのデータを受け取って一度に更新できるようにする
  accepts_nested_attributes_for :responses

  validates :color_name, presence: true
end
