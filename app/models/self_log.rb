class SelfLog < ApplicationRecord
  belongs_to :user
  belongs_to :color
  has_many :Whether_logs 

end
