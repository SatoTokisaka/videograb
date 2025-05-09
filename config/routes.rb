require "sidekiq/web"  # Ensure this is required at the top of the file

Rails.application.routes.draw do
  resources :videos do
    member do
      get :download_video
      get :status
    end
  end

  require "sidekiq/web"
mount Sidekiq::Web => "/sidekiq"

  get "up" => "rails/health#show", as: :rails_health_check

  root "videos#new"
end
