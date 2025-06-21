FactoryBot.define do
  factory :weather_log do
    association :self_log

    city { "東京都" }
    sequence(:weather_pressure) { |n| n }
    sequence(:weather_icon) { |n| "0#{n}d" }
    weather_name { "東京都" }
    sequence(:temperature) { |n| n }
    sequence(:temp_max) { |n| n }
    sequence(:temp_min) { |n| n }
    description { "雲" }
  end
end
