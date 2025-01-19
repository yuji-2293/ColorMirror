class WhetherLog < ApplicationRecord
  has_many :whether_logs, dependent: :destroy
end
