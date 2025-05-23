Rails.application.routes.draw do
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    passwords: "users/passwords",
    confirmations: "users/confirmations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  devise_scope :user do
    post "users/confirmation/resend", to: "users/confirmations#resend", as: :resend_confirmation
    get "users/confirmation/confirm", to: "users/confirmations#confirm", as: :confirm_confirmation
    get "users/password/reset_password", to: "users/passwords#reset_password", as: :reset_password
    get "users/registration/edit_user", to: "users/registrations#edit_user", as: :edit_user
    get "users/registration/edit_city", to: "users/registrations#edit_city", as: :edit_city
    delete "/users/unlink_google_account", to: "users/omniauth_callbacks#unlink_google_account", as: :unlink_google_account
  end
  resource :users, only: [ :show, :edit, :destroy, :update ] do
    get "profile", to: "users#show", as: "profile"
    get "reminder", to: "users#reminder", as: "reminder"
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "home#index"
  get "/home/privacy", to: "home#privacy", as: :privacy
  get "/home/rules", to: "home#rules", as: :rules
  get "colors/top" => "colors#top"

  resources :colors do
  collection do
    get "/colors/form", to: "colors#form", as: :form
  end
end

  resources :self_logs, only: [ :index, :show, :create, :destroy ] do
    member do
      get :ai_response
    end
    resources :weather_logs, only: [ :index, :show, :create, :destroy ]
    # get "colors/:id/response", to: "colors#response", as: :response
  end
  resources :analysis_results, only: [ :index, :show, :create, :destroy ]

  # chatbot機能
  get "chatbots/ask" => "chatbots#ask"
  post "chatbots/answer" => "chatbots#answer"

  # OpenWeatherAPI機能のルーティング
  get "weather", to: "weathers#index", as: :weather
  get "weather/show", to: "weathers#show", as: :show_weather, defaults: { format: :json }

  # JSからheatmap_dataへのエンドポイント
  get "heatmap", to: "result_maps#heatmap_data", as: :heatmap
  # JSからradar_map_dataへのエンドポイント
  get "map", to: "result_maps#map_data", as: :map
  # JSからopen AI へのエンドポイント
  post "/colors/analyze", to: "colors#analyze"
  # LINEルーティング
  post "/callback", to: "line#callback", as: :callback

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  # mount MissionControl::Jobs::Engine, at: "/jobs"
end
