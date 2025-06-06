FactoryBot.define do
  factory :user do
  name { "user" }
  sequence(:email) { |n| "user_#{n}@example.com" }
  prefecture { "東京都" }
  password { "password" }
  password_confirmation { "password" }
  end
end
