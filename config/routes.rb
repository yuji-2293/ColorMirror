Rails.application.routes.draw do
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    passwords: "users/passwords",
    confirmations: "users/confirmations"
  }
  devise_scope :user do
    post "users/confirmation/resend", to: "users/confirmations#resend", as: :resend_confirmation
    get "users/password/reset_password", to: "users/passwords#reset_password", as: :reset_password
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "home#index"
  get "colors/top" => "colors#top"

  resources :colors do
    resources :self_logs, only: [ :index, :show, :create, :destroy ]
    resources :weather_logs, only: [ :index, :show, :create, :destroy ]
  end

  # chatbot機能
  get "chatbots/ask" => "chatbots#ask"
  post "chatbots/answer" => "chatbots#answer"

  # OpenWeatherAPI機能のルーティング
  get "weather", to: "weathers#index", as: :weather
  get "weather/show", to: "weathers#show", as: :show_weather, defaults: { format: :json }

  # JSからopen AI へのルーティング
  post "/colors/analyze", to: "colors#analyze"
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
