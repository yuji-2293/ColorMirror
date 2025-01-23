class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  scope :today_form, -> { where(created_at: Time.current.beginning_of_day..Time.current.end_of_day)
  .order(created_at: :desc)
  .limit(1)
}
end
