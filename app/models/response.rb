class Response < ApplicationRecord
  belongs_to :self_log
  has_many :colors, through: :self_logs, dependent: :destroy
  has_many :Analysis_results, dependent: :destroy
  
end
