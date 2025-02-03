class User < ApplicationRecord
  has_many :self_logs
  has_many :colors, through: :self_logs, dependent: :destroy
  has_many :responses, through: :self_logs, dependent: :destroy
  has_many :weather_logs, through: :self_logs, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
