class Response < ApplicationRecord
  has_many :self_logs, dependent: :destroy
  has_many :Analysis_results, dependent: :destroy
end
