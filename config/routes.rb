Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    passwords: "users/passwords"
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "colors#top"
  resources :colors

  # chatbot機能
  get "chatbots/ask" => "chatbots#ask"
  post "chatbots/answer" => "chatbots#answer"
  # OpenWeatherAPI機能のルーティング
  get "weather", to: "weathers#index", as: :weather
  get "weather/show", to: "weathers#show", as: :show_weather

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
