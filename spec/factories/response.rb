FactoryBot.define do
  factory :response do
    association :self_log
    color_analysis { Faker::Color_Analysis.color_analysis}
    weather_analysis { Faker::Weather_Analysis.weather_analysis}
  end
end
