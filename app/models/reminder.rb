class Reminder < ApplicationRecord
  has_many :Reminders, dependent: :destroy
end
