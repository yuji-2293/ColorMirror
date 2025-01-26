class Response < ApplicationRecord
  belongs_to :self_log
  has_one :color, through: :self_log
  has_many :Analysis_results, dependent: :destroy

end
